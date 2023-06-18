//
//  VoteViewModel.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 25.04.23
//

import Foundation
import Networking
import UIKit

class VoteViewModel: ObservableObject {
	@Published var alreadyVoted = world.keychain.alreadyVoted

	@Published var isLoadingVotings = true

	init() {
		Task {
			await loadVotes()
		}
	}

	func loadVotes() async {}

	func fetchVotes() async throws {}

	@MainActor
	func vote() async {
		guard !alreadyVoted else { return }

		world.keychain.alreadyVoted = true
		world.keychain.votedDeviceId = UIDevice.current.identifierForVendor?.uuidString

		updateValuesFromKeychain()
	}

	func updateValuesFromKeychain() {
		alreadyVoted = world.keychain.alreadyVoted
	}
}
