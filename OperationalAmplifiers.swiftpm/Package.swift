// swift-tools-version: 5.6

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "OperationalAmplifier",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "OperationalAmplifier",
            targets: ["AppModule"],
            bundleIdentifier: "thomas-w12.operational-amplifier",
            teamIdentifier: "KFLUALYF42",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .asset("AppIcon"),
            accentColor: .asset("AccentColor"),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .landscapeRight,
                .landscapeLeft
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/colinc86/LaTeXSwiftUI", .branch("main")),
        .package(url: "https://github.com/simibac/ConfettiSwiftUI", "1.0.0"..<"2.0.0"),
        .package(url: "https://github.com/joogps/IrregularGradient", "2.0.0"..<"3.0.0"),
        .package(url: "https://github.com/colinc86/MathJaxSwift", from: "3.2.2"),
        .package(url: "https://github.com/exyte/SVGView", from: "1.0.4"),
        .package(url: "https://github.com/kean/Nuke", from: "11.3.1"),
        .package(url: "https://github.com/Kitura/swift-html-entities", from: "4.0.1")
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            dependencies: [
                "MathJaxSwift",
                "SVGView",
                "Nuke",
                .product(name: "HTMLEntities", package: "swift-html-entities"),
                .product(name: "LaTeXSwiftUI", package: "latexswiftui"),
                .product(name: "ConfettiSwiftUI", package: "confettiswiftui"),
                .product(name: "IrregularGradient", package: "irregulargradient")
            ],
            path: ".",
            resources: [
                .process("Fonts")
            ]
        )
    ]
)
