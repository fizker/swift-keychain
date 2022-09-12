// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "swift-keychain",
	products: [
		.library(
			name: "Keychain",
			targets: ["Keychain"]
		),
	],
	dependencies: [
	],
	targets: [
		.target(
			name: "Keychain",
			dependencies: []
		),
		.testTarget(
			name: "KeychainTests",
			dependencies: ["Keychain"]
		),
	]
)
