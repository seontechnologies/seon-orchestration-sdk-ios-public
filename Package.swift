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
        .package(
            url: "https://github.com/abbassabetinezhad-seon/SEONResolver",
            from: "1.5.2"
        ),
        .package(
            url: "https://github.com/seontechnologies/seon-ios-sdk-swift-package",
            exact: "5.6.1"
        ),
        .package(
            url: "https://github.com/regulaforensics/DocumentReader-Swift-Package",
            exact: "9.1.5702"
        ),
        .package(
            url: "https://github.com/regulaforensics/DocumentReaderRFID-Swift-Package",
            exact: "9.1.15618"
        ),
    ],
    targets: [
        .target(
            name: "SEONOrch",
            dependencies: [
                .target(name: "SEONOrchSDK"),
                .product(name: "SeonSDK",        package: "seon-ios-sdk-swift-package"),
                .product(name: "SEONResolver",   package: "SEONResolver"),
                .product(name: "DocumentReader", package: "DocumentReader-Swift-Package"),
                .product(name: "RFID",           package: "DocumentReaderRFID-Swift-Package"),
            ]
        ),
        .binaryTarget(
            name: "SEONOrchSDK",
            url: "https://github.com/seontechnologies/seon-orchestration-sdk-ios-public/releases/download/v1.0.2/SEONOrchSDK_SPM.zip",
            checksum: "6cef79966cdabd7250720282f8a423676a0e9a1857f06a77559cd1e768e0c7f5"
        )
    ]
)
