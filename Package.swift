// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NavigationDrawer",
    platforms: [
        .macOS(.v13),
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "NavigationDrawer",
            targets: ["NavigationDrawer"]),
    ],
    targets: [
        .target(name: "NavigationDrawer")
    ]
)
