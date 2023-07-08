//
//  VoteViewModel.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 08.07.23.
//

import Networking
import SwiftUI

class VoteViewModel: ObservableObject {
	@Published private(set) var voting: Voting
	@Published private(set) var votedFor: VoteEvent? = nil
	@Published private(set) var isLoading: Bool = false
	@Published private(set) var voteError: String? = nil

	private var votesViewModel: VotesViewModel?

	init(voting: Voting, votesViewModel: VotesViewModel? = nil) {
		self.voting = voting
		self.votesViewModel = votesViewModel
		votedFor = voting.hasAlreadyVotedFor
	}

	@MainActor
	func vote(for event: Event) async {
		let voteForEvent = VoteEvent(vote: voting, event: event)
		let votedForEvents = world.keychain.alreadyVotedIds

		guard !votedForEvents.contains(voteForEvent) else {
			return
		}

		isLoading = true

		do {
			try await postVote(voteForEvent)
			await world.keychain.saveVote(voteForEvent)

			withAnimation {
				self.votedFor = voteForEvent
			}
		} catch {
			withAnimation {
				self.voteError = error.localizedDescription
			}
		}

		withAnimation {
			self.isLoading = false
		}
	}

	func postVote(_ voteFor: VoteEvent) async throws {
		guard let deviceId = await UIDevice.current.identifierForVendor?.uuidString else {
			throw DeviceIdError.noDeviceId
		}
		let url = world.serverUrlWith(path: "/api/votes")

		let requestBody = Vote(
			votingId: voteFor.voteId,
			eventId: voteFor.eventId,
			deviceId: deviceId
		)

		let httpUrlResult = try await URLSession.shared.noData(
			.post,
			from: url,
			withRequestBody: requestBody
		)

		guard httpUrlResult.statusCode == 200 else {
			throw VoteError.failedToVote
		}

		print(httpUrlResult.statusCode)
	}
}

enum DeviceIdError: Error {
	case noDeviceId
}

enum VoteError: Error {
	case failedToVote
}
