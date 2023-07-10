// Copyright © 2023 IRFC

import Foundation

var world = World()

struct World {
	private let config = Config()

	let keychain = KeychainWrapper()

	func serverUrlWith(path: String) -> URL {
		var components = config.serverURLComponents
		components.path = path
		return components.url!
	}
}
