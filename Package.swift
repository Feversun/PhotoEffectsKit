// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "PhotoEffectsKit",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "PhotoEffectsKit",
            targets: ["PhotoEffectsKit"]),
    ],
    targets: [
        .target(
            name: "PhotoEffectsKit"),
        .testTarget(
            name: "PhotoEffectsKitTests",
            dependencies: ["PhotoEffectsKit"]),
    ]
)
