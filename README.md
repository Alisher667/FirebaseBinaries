# FirebaseBinaries

Firebase Apple SDK в виде SPM-пакета из официального `Firebase.zip`
([firebase-ios-sdk releases](https://github.com/firebase/firebase-ios-sdk/releases)).
xcframework'и не пересобираются и сохраняют подпись Google. Они лежат не в git,
а в GitHub Releases этого репозитория и подключаются через
`binaryTarget(url:checksum:)`.

## Подключение

```swift
.package(url: "https://github.com/Alisher667/FirebaseBinaries.git", from: "12.19.1")
```

| Продукт | Что внутри |
|---|---|
| `FirebaseAnalytics` | Core + Analytics, GoogleAppMeasurement, IdentitySupport (IDFA) |
| `FirebaseCrashlytics` | Core + Crashlytics, Sessions, GoogleDataTransport, Promises |
| `FirebaseMessaging` | Core + Messaging, GoogleDataTransport |
| `FirebaseRemoteConfig` | Core + RemoteConfig, ABTesting, SharedSwift |
| `FirebasePerformance` | Core + Performance и всё, что нужно ему из RemoteConfig/Sessions |
| `FirebaseBinaries` | Всё, кроме Performance. Прежний единый продукт, оставлен для совместимости |

Core — это FirebaseCore, FirebaseCoreInternal, FirebaseInstallations,
GoogleUtilities, nanopb, FBLPromises.

Подключайте в каждый таргет только нужные продукты. Из-за `-ObjC` в бинарник
попадает весь ObjC-код подключённых фреймворков, поэтому для app extension'ов
это заметно по размеру и памяти.

Требования к приложению:
- `-ObjC` в `OTHER_LDFLAGS`;
- iOS 15+, Xcode той версии, которую требует README в `Firebase.zip`.

`FirebasePerformance` начинает собирать данные сразу после `FirebaseApp.configure()`.
Отключается через `FirebasePerformanceCollectionEnabled = NO` в Info.plist.

### Crashlytics: загрузка dSYM

Run Script в Build Phases:

```sh
"${BUILD_DIR%/Build/*}/SourcePackages/checkouts/FirebaseBinaries/Frameworks/FirebaseCrashlytics/run"
```

`run` и `upload-symbols` хранятся в git, путь не меняется между версиями.

## Выпуск новой версии

1. Скачать и распаковать `Firebase.zip` нужной версии.
2. `scripts/release.sh ~/Downloads/Firebase <версия>`: проверяет подпись,
   проверяет линковку каждого продукта, пакует zip'ы в `.release/<версия>/zips`,
   генерирует `Package.swift` и обновляет `run`/`upload-symbols`.
   Zip'ы воспроизводимые: повторный запуск даёт те же checksum'ы.
3. Закоммитить `Package.swift` и `Frameworks/`, запушить ветку.
4. `scripts/release.sh ~/Downloads/Firebase <версия> --upload` создаёт GitHub Release
   с zip'ами, и тег ставится на запушенный коммит. Нужен `gh` (`brew install gh`).

Состав продуктов задаётся в начале `scripts/release.sh` (`CORE`, `PRODUCTS`)
по `METADATA.md` из `Firebase.zip`.
