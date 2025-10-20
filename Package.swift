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
            checksum: "490b1017f2caeb0b7fb24962e8ee7e51e087f1c225abbbac3b204af679563102"
        )
    ]
)