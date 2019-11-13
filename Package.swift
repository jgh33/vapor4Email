// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "vapor4demo",
    platforms: [
       .macOS(.v10_14)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0-beta.1"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0-beta.1"),
        .package(url: "https://github.com/vapor/fluent-mysql-driver.git", from: "4.0.0-beta.1"),

        
        
        .package(url: "https://github.com/IBM-Swift/Swift-SMTP.git", from: "5.1.2")

    ],
    targets: [
        .target(name: "App", dependencies: ["Fluent", "FluentMySQLDriver", "SwiftSMTP", "Vapor"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
