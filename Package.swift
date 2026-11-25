// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "LumiThemePack",
    defaultLocalization: "en",
    platforms: [.macOS(.v14), .iOS(.v17), .visionOS(.v1)],
    products: [
        .library(name: "LumiThemePack", targets: ["LumiThemePack"])
    ],
    dependencies: [
        // iOS 外观页使用 LumiUI 的主题环境与语义色，低于该版本无法编译。
        .package(url: "https://github.com/lumi-softworks/LumiUI.git", from: "1.11.1"),
        .package(url: "https://github.com/lumi-softworks/LumiProviders.git", from: "1.18.0")
    ],
    targets: [
        .target(
            name: "LumiThemePack",
            dependencies: [
                .product(name: "LumiUI", package: "LumiUI"),
                .product(name: "ProviderTheme", package: "LumiProviders")
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "LumiThemePackTests",
            dependencies: [
                "LumiThemePack",
                .product(name: "ProviderTheme", package: "LumiProviders")
            ],
            path: "Tests/LumiThemePackTests"
        )
    ]
)
