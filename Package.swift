// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftXlsxwriter",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftXlsxwriter",
            targets: ["SwiftXlsxwriter"])
    ],
    dependencies: [
        .package(url: "https://github.com/skeyboy/libxlsxwriter", branch: "main")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftXlsxwriter",
            dependencies: [
                .product(name: "libxlsxwriter", package: "libxlsxwriter")
            ]),
        .executableTarget(name: "Examples", dependencies: ["SwiftXlsxwriter"]),
        .testTarget(
            name: "SwiftXlsxwriterTests",
            dependencies: ["SwiftXlsxwriter"]
        ),
    ]
)
