// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FirebaseBinaries",
    platforms: [.macOS(.v10_13),
                .iOS(.v11)],
    products: [
        .library(
            name: "FirebaseBinaries",
            targets: [
                "FBLPromises",
                "FirebaseAnalytics",
                "FirebaseAnalyticsSwift",
                "FirebaseCore",
                "FirebaseCoreInternal",
                "FirebaseInstallations",
                "GoogleAppMeasurement",
                "GoogleAppMeasurementIdentitySupport",
//                "GoogleUtilities",
                "nanopb",
                "FirebaseCrashlytics",
                "GoogleDataTransport",
                "FirebaseMessaging",
                "FirebaseDynamicLinks"
            ]),
    ],

    targets: [
        .binaryTarget(name: "FBLPromises", path: "Sources/Frameworks/FirebaseAnalytics/FBLPromises.xcframework"),
        .binaryTarget(name: "FirebaseAnalytics", path: "Sources/Frameworks/FirebaseAnalytics/FirebaseAnalytics.xcframework"),
        .binaryTarget(name: "FirebaseAnalyticsSwift", path: "Sources/Frameworks/FirebaseAnalytics/FirebaseAnalyticsSwift.xcframework"),
        .binaryTarget(name: "FirebaseCore", path: "Sources/Frameworks/FirebaseAnalytics/FirebaseCore.xcframework"),
        .binaryTarget(name: "FirebaseCoreInternal", path: "Sources/Frameworks/FirebaseAnalytics/FirebaseCoreInternal.xcframework"),
        .binaryTarget(name: "FirebaseInstallations", path: "Sources/Frameworks/FirebaseAnalytics/FirebaseInstallations.xcframework"),
        .binaryTarget(name: "GoogleAppMeasurement", path: "Sources/Frameworks/FirebaseAnalytics/GoogleAppMeasurement.xcframework"),
        .binaryTarget(name: "GoogleAppMeasurementIdentitySupport", path: "Sources/Frameworks/FirebaseAnalytics/GoogleAppMeasurementIdentitySupport.xcframework"),
//        .binaryTarget(name: "GoogleUtilities", path: "Sources/Frameworks/FirebaseAnalytics/GoogleUtilities.xcframework"),
        .binaryTarget(name: "nanopb", path: "Sources/Frameworks/FirebaseAnalytics/nanopb.xcframework"),
        .binaryTarget(name: "FirebaseCrashlytics", path: "Sources/Frameworks/FirebaseCrashlytics/FirebaseCrashlytics.xcframework"),
        .binaryTarget(name: "GoogleDataTransport", path: "Sources/Frameworks/FirebaseCrashlytics/GoogleDataTransport.xcframework"),
        .binaryTarget(name: "FirebaseMessaging", path: "Sources/Frameworks/FirebaseMessaging/FirebaseMessaging.xcframework"),
        .binaryTarget(name: "FirebaseDynamicLinks", path: "Sources/Frameworks/FirebaseDynamicLinks/FirebaseDynamicLinks.xcframework")
    ]
)
