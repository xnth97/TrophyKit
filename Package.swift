// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TrophyKit",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "TrophyKit",
            targets: ["TrophyKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "TrophyKit",
            dependencies: [],
            path: "TrophyKit"),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
