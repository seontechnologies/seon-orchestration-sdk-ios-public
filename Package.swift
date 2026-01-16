// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SEONOrchSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "SEONOrchSDK",
            targets: ["SEONOrch"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/hmlongco/Resolver", from: "1.5.1"),
        .package(
            url: "https://github.com/seontechnologies/seon-ios-sdk-swift-package",
            exact: "5.6.1"
        )
    ],
    targets: [
        .target(
            name: "SEONOrch",
            dependencies: [
                .target(name: "SEONOrchSDK"),
                .product(name: "SeonSDK", package: "seon-ios-sdk-swift-package"),
                .product(name: "Resolver", package: "Resolver")
            ]
        ),
        .binaryTarget(
            name: "SEONOrchSDK",
            url: "https://github.com/seontechnologies/seon-orchestration-sdk-ios-public/releases/download/v0.1.0/SEONOrchSDK_SPM.zip",
            checksum: "9f240835d649275b8dfd3c47b03df542efc1901f91d6afd383d0216e61ef866c"
        )
    ]
)
