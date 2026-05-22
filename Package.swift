// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "FriskyFlusk",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Executable product
        .executable(
            name: "FriskyFluskApp",
            targets: ["FriskyFluskApp"]
        )
    ],
    dependencies: [
        // No external dependencies
    ],
    targets: [
        .executableTarget(
            name: "FriskyFluskApp",
            path: "Sources/FriskyFluskApp"
        )
    ]
)
