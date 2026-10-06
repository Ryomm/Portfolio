// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Portfolio",
    platforms: [.macOS(.v26)],
    dependencies: [
        .package(url: "https://github.com/twostraws/Ignite.git", branch: "main")
    ],
    targets: [
        .executableTarget(
            name: "IgniteStarter",
            dependencies: ["Ignite"]),
    ]
)

package.targets.forEach { target in
    target.swiftSettings = (target.swiftSettings ?? []) + [
        .swiftLanguageMode(.v6),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableUpcomingFeature("ImmutableWeakCaptures")
    ]
}
