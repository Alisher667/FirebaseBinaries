// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FirebaseBinaries",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "FirebaseBinaries",
            targets: [
                "FirebaseBinaries",
                "FirebaseAnalytics",
                "FirebaseCore",
                "FirebaseCoreInternal",
                "FirebaseInstallations",
                "GoogleAppMeasurement",
                "GoogleAppMeasurementIdentitySupport",
                "GoogleUtilities",
                "nanopb",
                "FirebaseCrashlytics",
                "GoogleDataTransport",
                "FirebaseMessaging",
                "FirebaseDynamicLinks",
                "FirebaseRemoteConfig",
                "FirebaseABTesting",
                "FirebaseSharedSwift",
                "FirebaseCoreExtension",
                "FirebaseSessions",
                "FirebaseRemoteConfigInterop",
                "FirebaseAppCheckInterop",
                "FirebaseAuthInterop",
                "FirebaseFunctions",
                "FirebaseMessagingInterop",
                "GTMSessionFetcher"
            ]
        ),
    ],
    targets: [
        .binaryTarget(name: "FirebaseAnalytics", path: "Frameworks/FirebaseAnalytics/FirebaseAnalytics.xcframework"),
        .binaryTarget(name: "FirebaseCore", path: "Frameworks/FirebaseAnalytics/FirebaseCore.xcframework"),
        .binaryTarget(name: "FirebaseCoreInternal", path: "Frameworks/FirebaseAnalytics/FirebaseCoreInternal.xcframework"),
        .binaryTarget(name: "FirebaseInstallations", path: "Frameworks/FirebaseAnalytics/FirebaseInstallations.xcframework"),
        .binaryTarget(name: "GoogleAppMeasurement", path: "Frameworks/FirebaseAnalytics/GoogleAppMeasurement.xcframework"),
        .binaryTarget(name: "GoogleAppMeasurementIdentitySupport", path: "Frameworks/FirebaseAnalytics/GoogleAppMeasurementIdentitySupport.xcframework"),
        .binaryTarget(name: "GoogleUtilities", path: "Frameworks/FirebaseAnalytics/GoogleUtilities.xcframework"),
        .binaryTarget(name: "nanopb", path: "Frameworks/FirebaseAnalytics/nanopb.xcframework"),
        .binaryTarget(name: "FirebaseCrashlytics", path: "Frameworks/FirebaseCrashlytics/FirebaseCrashlytics.xcframework"),
        .binaryTarget(name: "GoogleDataTransport", path: "Frameworks/FirebaseCrashlytics/GoogleDataTransport.xcframework"),
        .binaryTarget(name: "FirebaseMessaging", path: "Frameworks/FirebaseMessaging/FirebaseMessaging.xcframework"),
        .binaryTarget(name: "FirebaseDynamicLinks", path: "Frameworks/FirebaseDynamicLinks/FirebaseDynamicLinks.xcframework"),
        .binaryTarget(name: "FirebaseRemoteConfig", path: "Frameworks/FirebaseRemoteConfig/FirebaseRemoteConfig.xcframework"),
        .binaryTarget(name: "FirebaseABTesting", path: "Frameworks/FirebaseRemoteConfig/FirebaseABTesting.xcframework"),
        .binaryTarget(name: "FirebaseSharedSwift", path: "Frameworks/FirebaseRemoteConfig/FirebaseSharedSwift.xcframework"),
        .binaryTarget(name: "FirebaseCoreExtension", path: "Frameworks/FirebaseCrashlytics/FirebaseCoreExtension.xcframework"),
        .binaryTarget(name: "FirebaseSessions", path: "Frameworks/FirebaseCrashlytics/FirebaseSessions.xcframework"),
        .binaryTarget(name: "FirebaseRemoteConfigInterop", path: "Frameworks/FirebaseCrashlytics/FirebaseRemoteConfigInterop.xcframework"),
        .binaryTarget(name: "FirebaseAppCheckInterop", path: "Frameworks/FirebaseFunctions/FirebaseAppCheckInterop.xcframework"),
        .binaryTarget(name: "FirebaseAuthInterop", path: "Frameworks/FirebaseFunctions/FirebaseAuthInterop.xcframework"),
        .binaryTarget(name: "FirebaseFunctions", path: "Frameworks/FirebaseFunctions/FirebaseFunctions.xcframework"),
        .binaryTarget(name: "FirebaseMessagingInterop", path: "Frameworks/FirebaseFunctions/FirebaseMessagingInterop.xcframework"),
        .binaryTarget(name: "GTMSessionFetcher", path: "Frameworks/FirebaseFunctions/GTMSessionFetcher.xcframework"),
        .target(
            name: "FirebaseBinaries",
            dependencies: [
                "FirebaseAnalytics",
                "FirebaseCore",
                "FirebaseCoreInternal",
                "FirebaseInstallations",
                "GoogleAppMeasurement",
                "GoogleAppMeasurementIdentitySupport",
                "GoogleUtilities",
                "nanopb",
                "FirebaseCrashlytics",
                "GoogleDataTransport",
                "FirebaseMessaging",
                "FirebaseDynamicLinks",
                "FirebaseRemoteConfig",
                "FirebaseABTesting",
                "FirebaseSharedSwift",
                "FirebaseCoreExtension",
                "FirebaseSessions",
                "FirebaseAppCheckInterop",
                "FirebaseAuthInterop",
                "FirebaseFunctions",
                "FirebaseMessagingInterop",
                "GTMSessionFetcher"
            ]
        )
    ]
)
