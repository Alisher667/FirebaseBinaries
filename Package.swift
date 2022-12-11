// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

//let package = Package(
//    name: "FirebaseBinaries",
//    platforms: [.macOS(.v10_13),
//                .iOS(.v12)],
//    products: [
//        .library(
//            name: "FirebaseBinaries",
//            targets: [
//                "FirebaseAnalytics",
//                "FirebaseAnalyticsSwift",
//                "FirebaseCore",
//                "FirebaseCoreInternal",
//                "FirebaseInstallations",
//                "GoogleAppMeasurement",
//                "GoogleAppMeasurementIdentitySupport",
//                "GoogleUtilities",
//                "nanopb",
//                "FirebaseCrashlytics",
//                "GoogleDataTransport",
//                "FirebaseMessaging",
//                "FirebaseDynamicLinks"
//            ]
//        ),
//    ],
//    targets: [
//        .binaryTarget(name: "FirebaseAnalytics", path: "Frameworks/FirebaseAnalytics/FirebaseAnalytics.xcframework"),
//        .binaryTarget(name: "FirebaseAnalyticsSwift", path: "Frameworks/FirebaseAnalytics/FirebaseAnalyticsSwift.xcframework"),
//        .binaryTarget(name: "FirebaseCore", path: "Frameworks/FirebaseAnalytics/FirebaseCore.xcframework"),
//        .binaryTarget(name: "FirebaseCoreInternal", path: "Frameworks/FirebaseAnalytics/FirebaseCoreInternal.xcframework"),
//        .binaryTarget(name: "FirebaseInstallations", path: "Frameworks/FirebaseAnalytics/FirebaseInstallations.xcframework"),
//        .binaryTarget(name: "GoogleAppMeasurement", path: "Frameworks/FirebaseAnalytics/GoogleAppMeasurement.xcframework"),
//        .binaryTarget(name: "GoogleAppMeasurementIdentitySupport", path: "Frameworks/FirebaseAnalytics/GoogleAppMeasurementIdentitySupport.xcframework"),
//        .binaryTarget(name: "GoogleUtilities", path: "Frameworks/FirebaseAnalytics/GoogleUtilities.xcframework"),
//        .binaryTarget(name: "nanopb", path: "Frameworks/FirebaseAnalytics/nanopb.xcframework"),
//        .binaryTarget(name: "FirebaseCrashlytics", path: "Frameworks/FirebaseCrashlytics/FirebaseCrashlytics.xcframework"),
//        .binaryTarget(name: "GoogleDataTransport", path: "Frameworks/FirebaseCrashlytics/GoogleDataTransport.xcframework"),
//        .binaryTarget(name: "FirebaseMessaging", path: "Frameworks/FirebaseMessaging/FirebaseMessaging.xcframework"),
//        .binaryTarget(name: "FirebaseDynamicLinks", path: "Frameworks/FirebaseDynamicLinks/FirebaseDynamicLinks.xcframework")
//    ]
//)


let frameworks = ["GTMSessionFetcher": "0c66514053e161ddb243cb9d5b3f97cb4a6e55868ab4f6dde6359a94f6177d9c",
                  "BoringSSL-GRPC": "9a36cb83b4a757b51d9cf3f72d98795359af87847e5a2972841c115d14dad4a3",
                  "Libuv-gRPC": "2a2c17cfe2567171d64e7d594046047be43e9926c7923482d3f56ddbf22bb864",
                  "GoogleDataTransport": "ec2636ff6d7d9d987ab164412742c9b483614a929e11ffd47f3353c674eec740",
                  "abseil": "bb46999cbdca451a26ca6a8198cee7c9101b3a2d34e4902428f59435b7dca320",
                  "AppAuth": "d30fbf1286a1964ee5f850a2b65f1649f01833bec7d0b09cfafcaea010761f0d",
                  "leveldb-library": "8b410795ee8edceb8ed5ace34f191c53027b36bd23b191fb1ee9d55b1fb00125",
                  "gRPC-Core": "c3fb7829b61bebb32960d4aa34a6725c9514a0aa81fad376719234afb19a70b3",
                  "FirebaseMessaging": "a4c2052b6963616a45173243aa50a3272a9cb358e32966c6ced5b0558608df3f",
                  "GoogleUtilities": "3999380ac97b13769a9c02759d378ad9c45cfa91cf076e4bac875cf9fe4715ba",
                  "FirebaseAnalyticsOnDeviceConversion": "8026eb027803a429b44c8351f5fd0daf009731277b4620783cee8202409d3402",
                  "GoogleAppMeasurementIdentitySupport": "e2979357530857642ea36f47cf87e99ad05c44956ab53885ad68545b172e15db",
                  "GoogleAppMeasurementOnDeviceConversion": "c5b5a199a07ee6c772ab1a873e37ee673a05b4742fd0287bc45f8b6cb8dcdf9a",
                  "FirebaseCore": "ef11d43538d7f7f7407752897c7220acde33c30904f119ecd2460f44162f0a5d",
                  "FirebaseDynamicLinks": "a3ed0a4261726b45f60b44bf1c69eb5477cc01a3ffb691e6f0f9847bd090ac58",
                  "FirebaseCrashlytics": "2a69f94aa268398caf4c16de69c02022c220b7c7c54cd63471f9c30a5c466ae8",
                  "FirebaseAnalytics": "6c3a97d7eb78ae119ee2e7528393bfc4e7e934f3b2767d8c56f5bf15511a629e",
                  "gRPC-C++": "73576cfdb704ff85e4a4a4f99cd0f9d80c54805599798ce963087a17ab370d7b",
                  "FirebaseCoreExtension": "651fe385f114147e06e7d5c00c037c6ebcd813b6e5c163632f9c0ee9672baab5",
                  "FirebaseCoreInternal": "2291d48bf9aa4fd54b350df4ef4afb596cf7e8f2ea0e313cd9fa8e0349625148",
                  "GoogleAppMeasurement": "81281b4f984f70fdc5c0391e7619e3efd0d2a0136321aa29020474d210bb78ea",
                  "FirebaseMessagingInterop": "e948c2c87c46fdfd3bd0bcdd5913afc79b56994523058e835afb2e1c0ae99d84",
                  "FirebaseCoreDiagnostics": "5b577d04c6b3055704c8765ae6730c65532fc8e5a7170e49902d7f85e3a94ceb",
                  "SwiftProtobuf": "36cdd0621223ff99253d391ac85f9f00ad79bb0cec951a32da152d2a9e171694",
                  "FirebaseAnalyticsSwift": "314e8737f258b6f2f24eb781b1929dc0e6eb0299fd6d2303adef36ff70e1caea",
                  "nanopb": "ec0566c8c43777a39d71976ea5962584f1b1b005e616f526f5c7468f16ec84da"]

let package = Package(
    name: "FirebaseBinaries",
    platforms: [.iOS(.v11), .macOS(.v10_13), .tvOS(.v12), .watchOS(.v7)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FirebaseBinaries",
            targets: Array.init(frameworks.keys)
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
//        .package(url: "https://github.com/jectivex/JXKit.git", .upToNextMajor(from: "3.3.2")),
    ],
    targets: frameworks.map { name, checksum in
            .binaryTarget(name: name,
                          url: "https://github.com/c-villain/FirebaseBinaries/releases/download/9.6.0/\(name).xcframework.zip",
                          checksum: checksum)
    }
)
