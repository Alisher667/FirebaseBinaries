// swift-tools-version: 5.7
// Сгенерировано scripts/release.sh из Firebase 12.19.0. Не редактировать вручную.

import PackageDescription

let version = "12.19.1"
let releases = "https://github.com/Alisher667/FirebaseBinaries/releases/download/\(version)"

func xcframework(_ name: String, _ checksum: String) -> Target {
    .binaryTarget(name: name, url: "\(releases)/\(name).xcframework.zip", checksum: checksum)
}

let core = ["FirebaseCore", "FirebaseCoreInternal", "FirebaseInstallations", "GoogleUtilities", "nanopb", "FBLPromises"]

let package = Package(
    name: "FirebaseBinaries",
    platforms: [
        .iOS(.v15),
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "FirebaseAnalytics", targets: core + ["FirebaseAnalytics", "GoogleAppMeasurement", "GoogleAppMeasurementIdentitySupport"]),
        .library(name: "FirebaseCrashlytics", targets: core + ["FirebaseCrashlytics", "FirebaseCoreExtension", "FirebaseSessions", "FirebaseRemoteConfigInterop", "GoogleDataTransport", "Promises"]),
        .library(name: "FirebaseMessaging", targets: core + ["FirebaseMessaging", "GoogleDataTransport"]),
        .library(name: "FirebaseRemoteConfig", targets: core + ["FirebaseRemoteConfig", "FirebaseABTesting", "FirebaseRemoteConfigInterop", "FirebaseSharedSwift"]),
        .library(name: "FirebasePerformance", targets: core + ["FirebasePerformance", "FirebaseRemoteConfig", "FirebaseABTesting", "FirebaseRemoteConfigInterop", "FirebaseSharedSwift", "FirebaseCoreExtension", "FirebaseSessions", "GoogleDataTransport", "Promises"]),
        // Прежний единый продукт (всё, кроме Performance), для совместимости со старыми версиями.
        .library(name: "FirebaseBinaries", targets: ["FirebaseBinaries"])
    ],
    targets: [
        xcframework("FBLPromises", "3c374f25d56f18eca926320238f1b93143d3e35145e6bbf6b2c8bc4fedc5f110"),
        xcframework("FirebaseABTesting", "5b8c1d019e74fedd94f691c5f708325d420e71830f96ed34b3b61162aa86b7c4"),
        xcframework("FirebaseAnalytics", "bb4ac5b26f4bcbf6a134c07086805e72c5dcf8db130dd34d2827784c71efd5c1"),
        xcframework("FirebaseCore", "b1bac004274e23fb8fbec15305b953f43fe9d1edd819db0ada5f3c0a419f7fe4"),
        xcframework("FirebaseCoreExtension", "952a5965631f1aa6e5d289bd9739e912593a8e32b573f5656f4dbe9b0b1bc9c2"),
        xcframework("FirebaseCoreInternal", "a3742c4e612249d977d3fd8c9b96a1e423f00ba94690d0df089ba623f736cd66"),
        xcframework("FirebaseCrashlytics", "a0baaa6905911ce871594ed89ec3e8146bbbdef00a9573ca12e8a6dfac15e597"),
        xcframework("FirebaseInstallations", "f6f0e5fce278bd27125f36218a3a36b34fb07507ef804f2f04a15178a11c08db"),
        xcframework("FirebaseMessaging", "040c98ae7792add818a04f1dc385488e08c5abbba08adffa5c3580d516e3c30b"),
        xcframework("FirebasePerformance", "9f11bdbb5fc71242a333f72b17c197a628f445fa19020313e69d296944f79a20"),
        xcframework("FirebaseRemoteConfig", "5e237c3052d65c260596e5a6403e961368956a825210bcf5e2068d552a158a37"),
        xcframework("FirebaseRemoteConfigInterop", "a926a55d0901e7427cb79bae855e417cfd6aedbb3079de3bb71376d68b735ff6"),
        xcframework("FirebaseSessions", "92c8af2007e1e0a8f9542e082306cad88d46148dfaa8495176cbdd7cb2d6287e"),
        xcframework("FirebaseSharedSwift", "7090fc81c7b781ec62050263fb34414a2cd82808582f5e8d3c77ba4590da7cc6"),
        xcframework("GoogleAppMeasurement", "d75a9c4aeec9d0d419f467f2217669d620ce907ba81fd63bd830eccd79850dac"),
        xcframework("GoogleAppMeasurementIdentitySupport", "e7f7d3d9392efa1d9fbefa052714990937fa84e766802eba69ba8fe221eb41e1"),
        xcframework("GoogleDataTransport", "faf6908bd4fac4c9e6fd8a765c24be50c98c8ab9a70ad31783543f642a48b3ff"),
        xcframework("GoogleUtilities", "07824c7bd57af8d14af86ae40b170918e3a97517d31e593d96cb71e020164ce2"),
        xcframework("Promises", "6bf153cddcf5e05b0a20fa62dadcbd4f953a7039d3ddd892501efe4573d1e14e"),
        xcframework("nanopb", "22282748f32a6e7971804b75cc6b21ebd0eea1cf46083b957506aee3b2f53b20"),
        .target(
            name: "FirebaseBinaries",
            dependencies: [
                "FBLPromises",
                "FirebaseABTesting",
                "FirebaseAnalytics",
                "FirebaseCore",
                "FirebaseCoreExtension",
                "FirebaseCoreInternal",
                "FirebaseCrashlytics",
                "FirebaseInstallations",
                "FirebaseMessaging",
                "FirebaseRemoteConfig",
                "FirebaseRemoteConfigInterop",
                "FirebaseSessions",
                "FirebaseSharedSwift",
                "GoogleAppMeasurement",
                "GoogleAppMeasurementIdentitySupport",
                "GoogleDataTransport",
                "GoogleUtilities",
                "Promises",
                "nanopb"
            ]
        )
    ]
)
