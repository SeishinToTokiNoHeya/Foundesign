// swift-tools-version: 6.4

import PackageDescription

let package = Package(
  name: "Foundesign",
  platforms: [
    .iOS(.v16),
    .macOS(.v13)
  ],
  products: [
    .library(
      name: "Foundesign",
      targets: ["Foundesign"]
    ),
  ],
  targets: [
    .target(
      name: "Foundesign",
      dependencies: [
        "FoundesignComponent",
        "FoundesignFoundation"
      ]
    ),
    .target(
      name: "FoundesignComponent",
      dependencies: [
        "FoundesignFoundation"
      ]
    ),
    .target(
      name: "FoundesignFoundation",
    ),
  ]
)
