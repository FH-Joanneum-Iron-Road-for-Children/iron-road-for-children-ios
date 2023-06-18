import Foundation
import SimpleKeychain

public class KeychainWrapper {
	private let keychain = SimpleKeychain()

	public init() {}

	private var alreadyVotedKey = "already_voted"
	public var alreadyVoted: Bool {
		get {
			keychain.bool(forKey: alreadyVotedKey)
		}

		set {
			try? keychain.set(String(newValue), forKey: alreadyVotedKey)
		}
	}

	private var votedDeviceIdKey = "voted_device_id"
	public var votedDeviceId: String? {
		get {
			try? keychain.string(forKey: votedDeviceIdKey)
		}

		set {
			guard let newValue = newValue else { return }
			try? keychain.set(newValue, forKey: votedDeviceIdKey)
		}
	}

	public func deleteAll() {
		try? keychain.deleteAll()
	}
}

private extension SimpleKeychain {
	/**
	 - returns: false if the item is not in the Keychain
	 */
	func bool(forKey key: String) -> Bool {
		do {
			guard let string = try? string(forKey: key),
			      let bool = Bool(string)
			else { return false }

			return bool
		}
	}
}
