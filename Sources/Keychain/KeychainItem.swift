import Foundation

/// Represents the shared interface for the various `KeychainClass`es.
public protocol KeychainItem {
	typealias KeychainData = [CFString: Any]

	/// Creates a given implementation with the raw data loaded from the `Keychain` APIs.
	init(data: KeychainData) throws

	/// The data of the type returned in the data type taht the `Keychain` APIs use.
	var keychainData: KeychainData { get }

	/// The specific class ID constant that represents the instance.
	static var classIdentifier: CFString { get }
}
