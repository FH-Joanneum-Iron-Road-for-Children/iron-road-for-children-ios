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
