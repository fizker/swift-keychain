import Security

public class Keychain<Item: KeychainItem> {
	public init() {
	}

	public func add(_ item: Item) throws {
		let data = item.keychainData.merging(item.query.data) { (lhs, rhs) in
			rhs
		}
		let status = SecItemAdd(data as CFDictionary, nil)

		guard status == errSecSuccess
		else { throw KeychainError.unknownError(status) }
	}

	public func update(_ item: Item) throws {
		let status = SecItemUpdate(item.query, item.keychainData)

		switch status {
		case errSecSuccess:
			break
		case errSecItemNotFound:
			try add(item)
		default:
			throw KeychainError.unknownError(status)
		}
	}

	public func fetch(_ q: Item.Query) throws -> Item? {
		var rawItem: CFTypeRef?

		var query = q.data
		query[kSecMatchLimit] = kSecMatchLimitOne
		query[kSecReturnAttributes] = true
		query[kSecReturnData] = true
		query[kSecAttrSynchronizable] = kSecAttrSynchronizableAny

		let status = SecItemCopyMatching(query as CFDictionary, &rawItem)

		guard status != errSecItemNotFound
		else { return nil }

		guard status == errSecSuccess
		else { throw KeychainError.unknownError(status) }

		return try Item(data: rawItem as! Item.KeychainData)
	}

	public func delete(_ item: Item) throws {
		try delete(item.query)
	}

	public func delete(_ query: Item.Query) throws {
		let status = SecItemDelete(query.data as CFDictionary)
		switch status {
		case errSecSuccess, errSecItemNotFound:
			break
		default:
			throw KeychainError.unknownError(status)
		}
	}
}

private extension KeychainItem {
	/// Converts from ``KeychainData-swift.typealias`` to `CFDictionary`.
	///
	/// Note that this func is differs from using `value as CFDictionary`, because it essentially is `(value as KeychainData) as CFDictionary`.
	func typeConvert(_ input: KeychainData) -> CFDictionary {
		input as CFDictionary
	}

	/// The data of the type returned in the data type that the `Keychain` APIs use.
	///
	/// This should not include the data used to identify the item. That data should be included in ``keychainQuery`` instead.
	var keychainData: CFDictionary {
		typeConvert(keychainData)
	}

	/// The data that is used to identify the item in the `Keychain` store.
	var query: CFDictionary {
		typeConvert(query.data)
	}
}
