// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PlacesInfrastructure",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "PlacesInfrastructure",
            targets: ["PlacesInfrastructure"]),
        .library(
            name: "PlacesInfrastructureMocks",
            targets: ["PlacesInfrastructureMocks"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.10.1")),
        .package(url: "https://github.com/AliSoftware/OHHTTPStubs", .upToNextMajor(from: "9.1.0")),
        .package(path: "../MockFramework"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "PlacesInfrastructure",
            dependencies: [
                "Alamofire"
            ],
            path: "Sources/PlacesInfrastructure"),
        .target(
            name: "PlacesInfrastructureMocks",
            dependencies: [
                "PlacesInfrastructure",
                .product(name: "MockFramework", package: "MockFramework"),
            ],
            path: "Sources/PlacesInfrastructureMocks"),
        .testTarget(
            name: "PlacesInfrastructureTests",
            dependencies: [
                "PlacesInfrastructure",
                "PlacesInfrastructureMocks",
                .product(name: "OHHTTPStubsSwift", package: "OHHTTPStubs")
            ]
        ),
    ]
)
