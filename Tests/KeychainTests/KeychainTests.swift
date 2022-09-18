import XCTest
import Keychain

final class KeychainTests: XCTestCase {
	func test__add__itemIsValid__itemIsAdded() throws {
		/*@START_MENU_TOKEN@*/throw XCTSkip("Not implemented")/*@END_MENU_TOKEN@*/

		let keychain = Keychain<GenericPasswordKeychainItem>()
		try keychain.add(.init(account: "foo", password: "bar".data(using: .utf8)!))
	}

	func test__update__itemIsValid_itemAlreadyExists__existingItemIsUpdated() throws {
		/*@START_MENU_TOKEN@*/throw XCTSkip("Not implemented")/*@END_MENU_TOKEN@*/

		let keychain = Keychain<GenericPasswordKeychainItem>()
		try keychain.update(.init(account: "foo", password: "baz".data(using: .utf8)!))
	}

	func test__update__itemIsValid_itemDoesNotExist__itemIsAdded() throws {
		/*@START_MENU_TOKEN@*/throw XCTSkip("Not implemented")/*@END_MENU_TOKEN@*/

		let keychain = Keychain<GenericPasswordKeychainItem>()
		try keychain.update(.init(account: "foo", password: "bar".data(using: .utf8)!))
	}

	func test__fetch__itemExists_itemIsValid__itemIsReturned() throws {
		/*@START_MENU_TOKEN@*/throw XCTSkip("Not implemented")/*@END_MENU_TOKEN@*/

		let keychain = Keychain<GenericPasswordKeychainItem>()
		let item = try keychain.fetch(.init(account: "foo"))
	}

	func test__delete__itemExists__itemIsRemoved() throws {
		/*@START_MENU_TOKEN@*/throw XCTSkip("Not implemented")/*@END_MENU_TOKEN@*/

		let keychain = Keychain<GenericPasswordKeychainItem>()
		try keychain.delete(.init(account: "foo", password: "123".data(using: .utf8)!))
	}

	func test__delete__itemDoesNotExist__doesNotThrow() throws {
		/*@START_MENU_TOKEN@*/throw XCTSkip("Not implemented")/*@END_MENU_TOKEN@*/

		let keychain = Keychain<GenericPasswordKeychainItem>()
		try keychain.delete(.init(account: "foo", password: "123".data(using: .utf8)!))
	}
}
