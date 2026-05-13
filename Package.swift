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
            from: "1.5.1"
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
            url: "https://github.com/seontechnologies/seon-orchestration-sdk-ios-public/releases/download/v1.0.0/SEONOrchSDK_SPM.zip",
            checksum: "a474994769914ae049914625b74f6e5675ee79c7aebc2787f77f44690405b557"
        )
    ]
)
