// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "FriskyFlusk",
    platforms: [
        .iOS(.v17)
    ],
    products: [
    .executable(
        name: "FriskyFluskApp",
        targets: ["FriskyFluskApp"]
    )
]
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "FriskyFluskApp",
            path: "Sources/FriskyFluskApp"
        )
    ]
)
