//
//  VoteViewModel.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 25.04.23
//

import Foundation
import Networking
import SwiftUI
import UIKit

class VotesViewModel: ObservableObject {
	@Published var isLoadingVotings = true
	@Published var votings: [Voting] = []
	@Published var errorMsg: String?

	init(mockVotings: [Voting]? = nil) {
		if let mockVotings = mockVotings {
			isLoadingVotings = false
			votings = mockVotings

			return
		}

		Task {
			await loadVotes()
		}
	}

	@MainActor
	func loadVotes() async {
		withAnimation {
			isLoadingVotings = true
		}

		do {
			let votings = try await fetchVotes()

			withAnimation {
				self.votings = votings
				isLoadingVotings = false
			}
		} catch {
			withAnimation {
				errorMsg = error.localizedDescription
				isLoadingVotings = false
			}
		}
	}

	func fetchVotes() async throws -> [Voting] {
		let url = world.serverUrlWith(path: "/api/votings")
		let (body, _) = try await URLSession.shared.dataArray(.get, from: url, responseType: Voting.self)
		return body
	}

	@MainActor
	func vote(for voteForEvent: VoteEvent) async -> Bool {
		let votedForEvents = world.keychain.alreadyVotedIds
		guard !votedForEvents.contains(voteForEvent) else { return false }

		// TODO: send voting be request
		// TODO: handle loading state and show indicator

		await world.keychain.saveVote(voteForEvent)
		return true
	}
}
