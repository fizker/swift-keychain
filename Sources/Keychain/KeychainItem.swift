import Foundation

public protocol KeychainQuery {
	var data: KeychainItem.KeychainData { get }
}

/// Represents the shared interface for the various `KeychainClass`es.
public protocol KeychainItem {
	typealias KeychainData = [CFString: Any]
	associatedtype Query: KeychainQuery

	/// Creates a given implementation with the raw data loaded from the `Keychain` APIs.
	init(data: KeychainData) throws

	/// The data of the type returned in the data type that the `Keychain` APIs use.
	///
	/// This should not include the data used to identify the item. That data should be included in ``keychainQuery`` instead.
	var keychainData: KeychainData { get }

	/// A container for the data that is used to identify the item in the `Keychain` store.
	var query: Query { get }

	/// The specific class ID constant that represents the instance.
	static var classIdentifier: CFString { get }
}
