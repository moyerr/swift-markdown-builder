// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "swift-markdown-builder",
    products: [
        .library(
            name: "MarkdownBuilder",
            targets: ["MarkdownBuilder"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-markdown", from: "0.5.0"),
    ],
    targets: [
        .executableTarget(
            name: "create-readme",
            dependencies: ["MarkdownBuilder"]
        ),
        .target(
            name: "MarkdownBuilder",
            dependencies: [
                .product(name: "Markdown", package: "swift-markdown"),
            ]
        ),
        .testTarget(
            name: "MarkdownBuilderTests",
            dependencies: ["MarkdownBuilder"]
        ),
    ]
)
