// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIUtilities",
    platforms: [
        .macOS(.v11),
        .macCatalyst(.v13),
        .iOS(.v13),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "SwiftUIUtilities",
            targets: ["SwiftUIUtilities"]),
    ],
    targets: [
        .target(
            name: "SwiftUIUtilities",
            dependencies: []),
        .testTarget(
            name: "SwiftUIUtilitiesTests",
            dependencies: ["SwiftUIUtilities"]),
    ]
)
