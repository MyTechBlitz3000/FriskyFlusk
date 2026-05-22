// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "FriskyFlusk",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Makes the app executable
        .executable(
            name: "FriskyFluskApp",
            targets: ["FriskyFluskApp"]
        )
    ],
    dependencies: [
    
    ],
    targets: [
        .executableTarget(
            name: "FriskyFluskApp",
            dependencies: []  // Add Alamofire here if used
        ),
        .testTarget(
            name: "FriskyFluskAppTests",
            dependencies: ["FriskyFluskApp"]
        )
    ]
)
