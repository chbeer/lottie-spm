// swift-tools-version:5.6

import PackageDescription

/// A precompiled XCFramework of the lottie-ios repo that was compiled with Xcode 15.2 / Swift 5.9.
/// This XCFramework can be used by Xcode 15.0 and later.
let lottieXCFramework = Target.binaryTarget(
  name: "Lottie",
  url: "https://github.com/airbnb/lottie-ios/releases/download/4.5.1/Lottie.xcframework.zip",
  checksum: "4b236af575d08526703919c5cd74d54772730e42b21bde2296bac07ad9ce5cda")

let package = Package(
  name: "Lottie",
  platforms: [.iOS("13.0"), .macOS("10.15"), .tvOS("13.0"), .custom("visionOS", versionString: "1.0")],
  products: [.library(name: "Lottie", targets: ["Lottie", "_LottieStub"])],
  targets: [
    lottieXCFramework,
    
    // Without at least one regular (non-binary) target, this package doesn't show up
    // in Xcode under "Frameworks, Libraries, and Embedded Content". That prevents
    // Lottie from being embedded in the app product, causing the app to crash when
    // ran on a physical device. As a workaround, we can include a stub target
    // with at least one source file.
    // https://github.com/apple/swift-package-manager/issues/6069
    .target(name: "_LottieStub"),
    
    .testTarget(
      name: "LottieTests",
      dependencies: ["Lottie"],
      path: "Tests")
  ])
