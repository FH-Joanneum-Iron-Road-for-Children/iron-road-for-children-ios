//
//  VoteViewModel.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 08.07.23.
//

import SwiftUI

class VoteViewModel: ObservableObject {
	@Published private(set) var voting: Voting
	@Published private(set) var votedFor: VoteEvent? = nil
	@Published private(set) var isLoading: Bool = false

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

		// TODO: send voting be request

		await world.keychain.saveVote(voteForEvent)

		withAnimation {
			self.votedFor = voteForEvent
			self.isLoading = false
		}
	}
}
