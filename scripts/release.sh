#!/bin/bash
#
# Готовит релиз FirebaseBinaries из распакованного Firebase.zip:
#   1. берёт по одной копии нужных xcframework'ов и проверяет подпись Google;
#   2. проверяет, что каждый продукт линкуется сам по себе (-ObjC, iOS Simulator);
#   3. пакует каждый xcframework в zip и считает checksum;
#   4. генерирует Package.swift с binaryTarget(url:checksum:);
#   5. обновляет Frameworks/FirebaseCrashlytics/{run,upload-symbols}.
#
# Использование:
#   scripts/release.sh <распакованный Firebase.zip> <версия> [--upload]
#
# --upload создаёт GitHub Release <версия> и загружает zip'ы (нужен gh).
# Тег с новым Package.swift пушится только ПОСЛЕ загрузки ассетов,
# иначе SPM получит 404 при резолве.

set -euo pipefail

REPO="Alisher667/FirebaseBinaries"

SRC="${1:?Путь к распакованному Firebase.zip}"
VERSION="${2:?Версия релиза, например 12.19.1}"
UPLOAD="${3:-}"

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="$ROOT/.release/$VERSION"
STAGE="$OUT/frameworks"
ZIPS="$OUT/zips"

# Базовый набор, без которого не работает ни один SDK.
CORE="FirebaseCore FirebaseCoreInternal FirebaseInstallations GoogleUtilities nanopb FBLPromises"

# Продукты: имя и фреймворки поверх CORE. Состав по METADATA.md из Firebase.zip.
PRODUCTS="
FirebaseAnalytics:FirebaseAnalytics GoogleAppMeasurement GoogleAppMeasurementIdentitySupport
FirebaseCrashlytics:FirebaseCrashlytics FirebaseCoreExtension FirebaseSessions FirebaseRemoteConfigInterop GoogleDataTransport Promises
FirebaseMessaging:FirebaseMessaging GoogleDataTransport
FirebaseRemoteConfig:FirebaseRemoteConfig FirebaseABTesting FirebaseRemoteConfigInterop FirebaseSharedSwift
FirebasePerformance:FirebasePerformance FirebaseRemoteConfig FirebaseABTesting FirebaseRemoteConfigInterop FirebaseSharedSwift FirebaseCoreExtension FirebaseSessions GoogleDataTransport Promises
"

# Код, которым проверяется линковка продукта.
probe() {
    case "$1" in
        FirebaseAnalytics)    echo 'Analytics.logEvent("probe", parameters: nil)' ;;
        FirebaseCrashlytics)  echo '_ = Crashlytics.crashlytics()' ;;
        FirebaseMessaging)    echo '_ = Messaging.messaging()' ;;
        FirebaseRemoteConfig) echo '_ = RemoteConfig.remoteConfig()' ;;
        FirebasePerformance)  echo '_ = Performance.sharedInstance()' ;;
    esac
}

product_names() { echo "$PRODUCTS" | sed '/^$/d' | cut -d: -f1; }
product_frameworks() { echo "$CORE $(echo "$PRODUCTS" | grep "^$1:" | cut -d: -f2)"; }
all_frameworks() { for p in $(product_names); do product_frameworks "$p"; done | tr ' ' '\n' | sed '/^$/d' | sort -u; }

# Состав FirebaseBinaries: прежний набор без Performance, чтобы у существующих
# пользователей не включался сбор performance-данных без их ведома.
compat_frameworks() { all_frameworks | grep -vx FirebasePerformance; }

log() { printf '\n==> %s\n' "$*"; }
die() { printf 'ошибка: %s\n' "$*" >&2; exit 1; }

[ -f "$SRC/METADATA.md" ] || die "$SRC не похож на распакованный Firebase.zip (нет METADATA.md)"

core_version=$(/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' \
    "$(find "$SRC" -maxdepth 2 -name FirebaseCore.xcframework | head -1)/ios-arm64/FirebaseCore.framework/Info.plist")
[ "${core_version%.*}" = "${VERSION%.*}" ] || die "в архиве FirebaseCore $core_version, а релиз $VERSION"
[ "$core_version" = "$VERSION" ] || echo "внимание: FirebaseCore $core_version, тег $VERSION"

rm -rf "$OUT"
mkdir -p "$STAGE" "$ZIPS"

log "Сбор и проверка подписи"
for name in $(all_frameworks); do
    src=$(find "$SRC" -maxdepth 2 -name "$name.xcframework" -type d | head -1)
    [ -n "$src" ] || die "в архиве нет $name.xcframework"
    rsync -a --exclude .DS_Store "$src" "$STAGE/"
    codesign --verify --strict "$STAGE/$name.xcframework" \
        || die "$name: подпись не прошла проверку"
    [[ "$(codesign -dv "$STAGE/$name.xcframework" 2>&1)" == *TeamIdentifier=EQHXZ8M8AV* ]] \
        || die "$name: подписан не Google"
    echo "  ok  $name"
done

log "Проверка линковки продуктов (iOS Simulator, -ObjC)"
SDK=$(xcrun --sdk iphonesimulator --show-sdk-path)
for product in $(product_names); do
    dir="$OUT/link/$product"
    mkdir -p "$dir"
    printf 'import %s\n%s\n' "$product" "$(probe "$product")" > "$dir/main.swift"
    args=()
    for fw in $(product_frameworks "$product"); do
        args+=(-F "$STAGE/$fw.xcframework/ios-arm64_x86_64-simulator" -framework "$fw")
    done
    xcrun swiftc -target arm64-apple-ios15.0-simulator -sdk "$SDK" \
        "$dir/main.swift" -o "$dir/probe" "${args[@]}" \
        -Xlinker -ObjC -lc++ -lz -lsqlite3 >"$dir/log" 2>&1 \
        || { cat "$dir/log"; die "$product не линкуется"; }
    echo "  ok  $product"
done

log "Упаковка и checksum"
for name in $(all_frameworks); do
    # Одинаковые mtime, сортированный порядок и без xattr (-X), symlink'и как есть (-y):
    # один и тот же вход всегда даёт тот же zip и тот же checksum.
    find "$STAGE/$name.xcframework" -exec touch -h -t 200001010000 {} +
    (cd "$STAGE" && find "$name.xcframework" | LC_ALL=C sort | zip -q -X -y -D "$ZIPS/$name.xcframework.zip" -@)
    check="$OUT/unzip/$name"
    mkdir -p "$check"
    unzip -q "$ZIPS/$name.xcframework.zip" -d "$check"
    codesign --verify --strict "$check/$name.xcframework" || die "$name: подпись сломалась после zip"
    sum=$(swift package compute-checksum "$ZIPS/$name.xcframework.zip")
    echo "$name $sum" >> "$OUT/checksums.txt"
    printf '  %-40s %s\n' "$name" "$(du -h "$ZIPS/$name.xcframework.zip" | cut -f1)"
done
echo "  всего: $(du -sh "$ZIPS" | cut -f1)"

log "Генерация Package.swift"
{
    cat <<EOF
// swift-tools-version: 5.7
// Сгенерировано scripts/release.sh из Firebase $core_version. Не редактировать вручную.

import PackageDescription

let version = "$VERSION"
let releases = "https://github.com/$REPO/releases/download/\\(version)"

func xcframework(_ name: String, _ checksum: String) -> Target {
    .binaryTarget(name: name, url: "\\(releases)/\\(name).xcframework.zip", checksum: checksum)
}

let core = [$(for fw in $CORE; do printf '"%s", ' "$fw"; done | sed 's/, $//')]

let package = Package(
    name: "FirebaseBinaries",
    platforms: [
        .iOS(.v15),
        .macOS(.v10_15)
    ],
    products: [
EOF
    for product in $(product_names); do
        extra=$(echo "$PRODUCTS" | grep "^$product:" | cut -d: -f2)
        printf '        .library(name: "%s", targets: core + [%s]),\n' \
            "$product" "$(for fw in $extra; do printf '"%s", ' "$fw"; done | sed 's/, $//')"
    done
    cat <<EOF
        // Прежний единый продукт (всё, кроме Performance), для совместимости со старыми версиями.
        .library(name: "FirebaseBinaries", targets: ["FirebaseBinaries"])
    ],
    targets: [
EOF
    while read -r name sum; do
        printf '        xcframework("%s", "%s"),\n' "$name" "$sum"
    done < "$OUT/checksums.txt"
    cat <<EOF
        .target(
            name: "FirebaseBinaries",
            dependencies: [
EOF
    compat_frameworks | sed 's/.*/                "&",/' | sed '$ s/,$//'
    cat <<EOF
            ]
        )
    ]
)
EOF
} > "$ROOT/Package.swift"

log "Скрипты Crashlytics"
mkdir -p "$ROOT/Frameworks/FirebaseCrashlytics"
rsync -a "$SRC/FirebaseCrashlytics/run" "$SRC/FirebaseCrashlytics/upload-symbols" "$ROOT/Frameworks/FirebaseCrashlytics/"

(cd "$ROOT" && swift package dump-package >/dev/null) || die "Package.swift не парсится"

if [ "$UPLOAD" = "--upload" ]; then
    # Тег создаётся при публикации релиза на коммите с этим Package.swift,
    # поэтому он должен быть закоммичен и запушен.
    command -v gh >/dev/null || die "нужен gh: brew install gh && gh auth login"
    cd "$ROOT"
    git diff --quiet HEAD -- Package.swift Frameworks \
        || die "закоммитьте Package.swift и Frameworks/, запушьте ветку и запустите снова с --upload"
    sha=$(git rev-parse HEAD)
    [ -n "$(git branch -r --contains "$sha")" ] || die "коммит $sha не запушен"
    log "GitHub Release $VERSION на $sha"
    gh release create "$VERSION" "$ZIPS"/*.zip -R "$REPO" --target "$sha" --draft \
        --title "Firebase $VERSION" --notes "Firebase $core_version, xcframework'и из Firebase.zip без изменений."
    gh release edit "$VERSION" -R "$REPO" --draft=false
    echo "Релиз опубликован, тег $VERSION указывает на $sha."
else
    log "Готово"
    echo "Zip'ы: $ZIPS"
    echo "Дальше: закоммитить Package.swift, запушить ветку и запустить снова с --upload"
    echo "(или вручную: Release $VERSION с этими zip'ами и тегом на этот коммит)."
fi
