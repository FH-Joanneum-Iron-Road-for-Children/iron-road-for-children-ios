// Copyright © 2023 IRFC

import AsyncAlgorithms
import Foundation
import SimpleKeychain

class KeychainWrapper {
	private let keychain = SimpleKeychain()
	private let voteForIdsChannel = AsyncChannel<VoteEvent>()

	init() {
		Task {
			await processvoteForIdsChannel()
		}
	}

	func saveVote(_ voteFor: VoteEvent) async {
		await voteForIdsChannel.send(voteFor)
		print("Saved vote for \(voteFor)")
	}

	func deleteAll() {
		try? keychain.deleteAll()
	}

	private func processvoteForIdsChannel() async {
		for await voteFor in voteForIdsChannel {
			storeVote(voteFor)
		}
	}

	private var alreadyVotedIdsKey = "already_voted_ids"
	var alreadyVotedIds: [VoteEvent] {
		guard let result: [VoteEvent] = keychain.json(forKey: alreadyVotedIdsKey) else {
			return []
		}
		return result
	}

	private func storeVote(_ voteEvent: VoteEvent) {
		var alreadyVotedIds = self.alreadyVotedIds
		alreadyVotedIds.append(voteEvent)
		keychain.setJson(alreadyVotedIds, forKey: alreadyVotedIdsKey)
	}
}

private extension SimpleKeychain {
	///
	/// - Parameters:
	///     - key: The key how with which the boolean is identified in the keychain
	/// - Returns: false if the item is not in the Keychain
	func bool(forKey key: String) -> Bool {
		do {
			guard let string = try? string(forKey: key),
			      let bool = Bool(string)
			else { return false }

			return bool
		}
	}

	/// This functions enables to get saved JSON from the keychain
	///
	/// - Parameters:
	///     - key: The key how with which the boolean is identified in the keychain
	/// - Returns: The generic item from the keychain
	func json<R: Codable>(forKey key: String) -> R? {
		let jsonDecoder = JSONDecoder()
		guard let data = try? data(forKey: key) else { return nil }
		return try? jsonDecoder.decode(R.self, from: data)
	}

	/// This functions enables to save Codabel objects as a JSON string to the keychain
	///
	/// - Parameters:
	///     - value: The generic value which should be saved to the keychain. This value must conform to the `Codabel` protocol
	///     - key: The key how with which the boolean is identified in the keychain
	func setJson<R: Codable>(_ value: R, forKey key: String) {
		let jsonEncoder = JSONEncoder()
		guard let data = try? jsonEncoder.encode(value),
		      let string = String(data: data, encoding: .utf8)
		else { return }

		try? set(string, forKey: key)
	}
}
