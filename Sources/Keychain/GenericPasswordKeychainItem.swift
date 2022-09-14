import Foundation

public struct GenericPasswordKeychainItem {
	public init(account: String, password: Data) {
		self.account = account
		self.password = password

		creationDate = nil
		modificationDate = nil
	}

	var account: String
	var password: Data

	let creationDate: Date?
	let modificationDate: Date?

	var service: String?

	// (macOS only)
	//var access:
	//var accessControl:

	// (iOS; also macOS if kSecAttrSynchronizable specified)
	var accessGroup: String?
	// (iOS; also macOS if kSecAttrSynchronizable specified)
	var accessible: String?

	var description: String?
	var comment: String?
	var creator: UInt?
	var type: UInt?
	var label: String?
	var isInvisible: Bool = false
	var isNegative: Bool?
	var isSynchronizable: Bool = false
	var genericData: Data?
}

extension GenericPasswordKeychainItem: KeychainItem {
	public static let classIdentifier = kSecClassGenericPassword

	public init(data: KeychainData) throws {
		guard data[kSecClass] as? String == Self.classIdentifier as String
		else { throw KeychainError.invalidClass(data[safe: kSecClass] as CFString?) }

		guard
			let account = data[kSecAttrAccount] as? String,
			let password = data[kSecValueData] as? Data
		else { throw KeychainError.requiredKeysMissing(Self.classIdentifier) }

		self.account = account
		self.password = password

		modificationDate = data[safe: kSecAttrModificationDate]
		creationDate = data[safe: kSecAttrCreationDate]

		accessGroup = data[safe: kSecAttrAccessGroup]
		accessible = data[safe: kSecAttrAccessible]
		description = data[safe: kSecAttrDescription]
		comment = data[safe: kSecAttrComment]
		creator = data[safe: kSecAttrCreator]
		type = data[safe: kSecAttrType]
		label = data[safe: kSecAttrLabel]
		isInvisible = data[safe: kSecAttrIsInvisible] ?? false
		isNegative = data[safe: kSecAttrIsNegative]
		service = data[safe: kSecAttrService]
		isSynchronizable = data[safe: kSecAttrSynchronizable] ?? false
		genericData = data[safe: kSecAttrGeneric]
	}

	public var keychainData: KeychainData {
		var v = [
			kSecAttrAccount: account,
			kSecValueData: password,
		] as [CFString : Any]
			//kSecAttrAccess: access,
			//kSecAttrAccessControl: accessControl,
		v[safe: kSecAttrAccessGroup] = accessGroup
		if let accessible {
			v[safe: kSecAttrAccessible] = accessible
			if #available(iOS 13.0, *) {
				v[safe: kSecUseDataProtectionKeychain] = true
			}
		}
		v[safe: kSecAttrDescription] = description
		v[safe: kSecAttrComment] = comment
		v[safe: kSecAttrCreator] = creator
		v[safe: kSecAttrType] = type
		v[safe: kSecAttrLabel] = label
		v[safe: kSecAttrIsInvisible] = isInvisible
		v[safe: kSecAttrIsNegative] = isNegative
		v[safe: kSecAttrService] = service
		v[safe: kSecAttrSynchronizable] = isSynchronizable
		v[safe: kSecAttrGeneric] = genericData
		return v
	}
}
