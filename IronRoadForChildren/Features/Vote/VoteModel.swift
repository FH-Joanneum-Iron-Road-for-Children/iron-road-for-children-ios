//
//  VoteModel.swift
//  IronRoadForChildren
//
//  Created by Daniel Zellner on 26.03.23.
//

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
}

struct VoteEvent: Codable {
	let voteId: Int
	let eventId: Int

	init(vote: Voting, event: Event) {
		voteId = vote.votingId
		eventId = event.eventId
	}
}
