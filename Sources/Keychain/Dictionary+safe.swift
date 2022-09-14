extension Dictionary where Value == Any {
	subscript<T>(safe key: Key) -> T? {
		get { self[key] as? T }
		set {
			if let newValue {
				self[key] = newValue as Any
			} else {
				self.removeValue(forKey: key)
			}
		}
	}
}
