// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FirebaseBinaries",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "FirebaseBinaries",
            targets: [
                "FirebaseBinaries",
                "FirebaseAnalytics",
                "FBLPromises",
                "FirebaseCore",
                "FirebaseCoreInternal",
                "FirebaseInstallations",
                "GoogleAppMeasurement",
                "GoogleAppMeasurementIdentitySupport",
                "GoogleUtilities",
                "nanopb",
                "FirebaseMessaging",
                "GoogleDataTransport"
            ]
        ),
    ],
    targets: [
        .binaryTarget(name: "FirebaseAnalytics", path: "Frameworks/FirebaseAnalytics/FirebaseAnalytics.xcframework"),
        .binaryTarget(name: "FBLPromises", path: "Frameworks/FirebaseAnalytics/FBLPromises.xcframework"),
        .binaryTarget(name: "FirebaseCore", path: "Frameworks/FirebaseAnalytics/FirebaseCore.xcframework"),
        .binaryTarget(name: "FirebaseCoreInternal", path: "Frameworks/FirebaseAnalytics/FirebaseCoreInternal.xcframework"),
        .binaryTarget(name: "FirebaseInstallations", path: "Frameworks/FirebaseAnalytics/FirebaseInstallations.xcframework"),
        .binaryTarget(name: "GoogleAppMeasurement", path: "Frameworks/FirebaseAnalytics/GoogleAppMeasurement.xcframework"),
        .binaryTarget(name: "GoogleAppMeasurementIdentitySupport", path: "Frameworks/FirebaseAnalytics/GoogleAppMeasurementIdentitySupport.xcframework"),
        .binaryTarget(name: "GoogleUtilities", path: "Frameworks/FirebaseAnalytics/GoogleUtilities.xcframework"),
        .binaryTarget(name: "nanopb", path: "Frameworks/FirebaseAnalytics/nanopb.xcframework"),
        .binaryTarget(name: "FirebaseMessaging", path: "Frameworks/FirebaseMessaging/FirebaseMessaging.xcframework"),
        .binaryTarget(name: "GoogleDataTransport", path: "Frameworks/FirebaseMessaging/GoogleDataTransport.xcframework"),
        .target(
            name: "FirebaseBinaries",
            dependencies: [
                "FirebaseAnalytics",
                "FBLPromises",
                "FirebaseCore",
                "FirebaseCoreInternal",
                "FirebaseInstallations",
                "GoogleAppMeasurement",
                "GoogleAppMeasurementIdentitySupport",
                "GoogleUtilities",
                "nanopb",
                "FirebaseMessaging",
                "GoogleDataTransport"
            ]
        )
    ]
)
