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
            url: "https://github.com/seontechnologies/seon-orchestration-sdk-ios-public/releases/download/v1.0.1/SEONOrchSDK_SPM.zip",
            checksum: "2a6887f55d789a84ba4af8f4f13dd9c7920e0c1446c6e05ece781040a90571bf"
        )
    ]
)
