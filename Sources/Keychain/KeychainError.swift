import Foundation

public enum KeychainError: Error {
	/// Thrown when ``KeychainItem/init(data:)`` is called with a dictionary where the class is not matching the ``KeychainItem/classIdentifier``.
	///
	/// The bundled value is the actual class found in the dictionary.
	case invalidClass(CFString?)

	/// Thrown when ``KeychainItem/init(data:)`` parses a dictinoary that is missing whatever keys the specific class needs.
	///
	/// The bundled value is the type of class that were attempted to be parsed.
	case requiredKeysMissing(CFString)

	/// Thrown for any unknown error that might come from the `Keychain` APIs.
	case unknownError(OSStatus)
}
