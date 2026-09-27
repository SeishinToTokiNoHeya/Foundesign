// swift-tools-version: 6.4

import PackageDescription

let package = Package(
  name: "Foundesign",
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
        "FoundesignFoundation"
      ]
    ),
    .target(
      name: "FoundesignFoundation",
    ),
  ]
)
