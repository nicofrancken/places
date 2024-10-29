// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PlacesDomain",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "PlacesDomain",
            targets: ["PlacesDomain"]),
        .library(
            name: "PlacesDomainMocks",
            targets: ["PlacesDomainMocks"]),
    ],
    dependencies: [
        .package(path: "../MockFramework"),
        .package(path: "../PlacesInfrastructure")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "PlacesDomain",
            dependencies: [
                "PlacesInfrastructure",
            ],
            path: "Sources/PlacesDomain"),
        .target(
            name: "PlacesDomainMocks",
            dependencies: [
                "PlacesDomain",
                .product(name: "MockFramework", package: "MockFramework")
            ],
            path: "Sources/PlacesDomainMocks"),
        .testTarget(
            name: "PlacesDomainTests",
            dependencies: [
                "PlacesDomain",
                "PlacesDomainMocks",
                .product(name: "PlacesInfrastructureMocks", package: "PlacesInfrastructure"),
                .product(name: "MockFramework", package: "MockFramework")
            ]
        ),
    ]
)
