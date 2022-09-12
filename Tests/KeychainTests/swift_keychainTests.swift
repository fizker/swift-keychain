import XCTest
@testable import Keychain

final class swift_keychainTests: XCTestCase {
	func testExample() throws {
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct
		// results.
		XCTAssertEqual(swift_keychain().text, "Hello, World!")
	}
}
