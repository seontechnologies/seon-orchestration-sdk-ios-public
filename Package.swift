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
            targets: ["SEONOrchSDK"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/hmlongco/Resolver", from: "1.5.1")
    ],
    targets: [
        .target(
            name: "SEONOrchSDK",
            dependencies: [
                .target(name: "SEONOrchSDK"),
            ]
        ),
        .binaryTarget(
            name: "SEONOrchSDK",
            url: "https://github.com/seontechnologies/seon-orchestration-sdk-ios-public/releases/download/v0.1.0/SEONOrchSDK_SPM.zip",
            checksum: "0e6da39d5c3823f5e7df37db8a7fd79aa60455e39b3cafc83f4f2b19552f82a2"
        )
    ]
)