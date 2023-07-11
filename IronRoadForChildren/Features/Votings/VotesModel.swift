// Copyright © 2023 IRFC

import Foundation

struct Band: Identifiable {
	let id = UUID()
	let bandName: String
	let description: String
	let status: Int
}

struct Voting: Codable {
	let votingId: Int
	let title: String
	let active: Bool
	let events: [Event]

	var hasAlreadyVotedFor: VoteEvent? {
		world.keychain.alreadyVotedIds.first(where: { $0.voteId == votingId })
	}
}

struct VoteEvent: Codable, Equatable {
	let voteId: Int
	let eventId: Int

	init(vote: Voting, event: Event) {
		voteId = vote.votingId
		eventId = event.eventId
	}

	init(voteId: Int, eventId: Int) {
		self.voteId = voteId
		self.eventId = eventId
	}
}

struct Vote: Codable {
	let votingId: Int
	let eventId: Int
	let deviceId: String
}
