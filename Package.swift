// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftOpenCV",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "SwiftOpenCV",
            targets: ["SwiftOpenCV", "ObjCOpenCV"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SwiftOpenCV",
            dependencies: ["ObjCOpenCV"],
            path: "Sources/Swift"
        ),
        .target(
            name: "ObjCOpenCV",
            dependencies: ["opencv2"],
            path: "Sources/ObjCOpenCV",
            cxxSettings: [
                .headerSearchPath("include")
            ]
        ),
        .binaryTarget(
            name: "opencv2",
            path: "opencv2.xcframework.zip"
        ),
        .testTarget(
            name: "SwiftOpenCVTests",
            dependencies: ["SwiftOpenCV"]
        )
    ],
    cxxLanguageStandard: CXXLanguageStandard.cxx11
)
