// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "CopyButtonToast",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "CopyButtonToast",
            targets: ["CopyButtonToast"]
        )
    ],
    targets: [
        .target(
            name: "CopyButtonToast"
        ),
        .testTarget(
            name: "CopyButtonToastTests",
            dependencies: ["CopyButtonToast"]
        )
    ]
)
