import Foundation

public struct GenericPasswordKeychainItem {
	public struct Query: KeychainQuery {
		public var data: [CFString : Any] {
			var v = [
				kSecClass: GenericPasswordKeychainItem.classIdentifier,
				kSecAttrAccount: account,
			] as [CFString : Any]
			v[safe: kSecAttrCreator] = creator
			return v
		}

		public init(account: String, creator: UInt? = nil) {
			self.account = account
			self.creator = creator
		}

		public var account: String
		public var creator: UInt?
	}

	public init(account: String, password: Data) {
		self.account = account
		self.password = password

		creationDate = nil
		modificationDate = nil
	}

	public var account: String
	public var password: Data

	public let creationDate: Date?
	public let modificationDate: Date?

	public var service: String?

	// (macOS only)
	//var access:
	//var accessControl:

	// (iOS; also macOS if kSecAttrSynchronizable specified)
	public var accessGroup: String?
	// (iOS; also macOS if kSecAttrSynchronizable specified)
	public var accessible: String?

	public var description: String?
	public var comment: String?
	public var creator: UInt?
	public var type: UInt?
	public var label: String?
	public var isInvisible: Bool = false
	public var isNegative: Bool?
	public var isSynchronizable: Bool = false
	public var genericData: Data?
}

extension GenericPasswordKeychainItem: KeychainItem {
	public static let classIdentifier = kSecClassGenericPassword

	public init(data: KeychainData) throws {
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

	public var query: Query {
		.init(account: account, creator: creator)
	}

	public var keychainData: KeychainData {
		var v = [
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
