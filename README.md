# swift-keychain

A helper for swiftifying the Keychain APIs.


## How to use

1. Add `.package(url: "https://github.com/fizker/swift-keychain.git", from: "0.1.0")` to the list of dependencies in your Package.swift file.
2. Add `.product(name: "Keychain", package: "swift-keychain")` to the dependencies of the targets that need to use the keychain.
3. Add `import Keychain` in the file and use the types. See the examples or tests for more details at this level.


## Examples

### Creating a Keychain

Start by creating a Keychain with the intended item class:

```swift
let keychain = Keychain<GenericPasswordKeychainItem>()
```

then create items on the keychain:

```swift
let passwordData = "secret password".data(using: .utf8)!
var item = GenericPasswordKeychainItem(account: "some account key", password: passwordData)
// configure any other things on the item
item.isSynchronizable = true

// then add it to the keychain
try keychain.add(item)
```

later on, fetch the item again using a query:

```swift
let query = GenericPasswordKeychainItem.Query(account: "some account key")

if let item = try keychain.fetch(query) {
	let password = String(data: item.password, encoding: .utf8)!
	// do something with the password
}
```
