// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "NicknameKit",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
        .tvOS(.v15),
        .watchOS(.v8),
        .visionOS(.v1),
    ],
    products: [
        .library(
            name: "NicknameKit",
            targets: ["NicknameKit"]
        ),
    ],
    targets: [
        .target(
            name: "NicknameKit"
        ),
        .testTarget(
            name: "NicknameKitTests",
            dependencies: ["NicknameKit"]
        ),
    ]
)
