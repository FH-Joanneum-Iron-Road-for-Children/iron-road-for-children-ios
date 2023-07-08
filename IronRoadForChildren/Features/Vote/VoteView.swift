//
//  VoteView.swift
//  IronRoadForChildren
//
//  Created by Daniel Zellner on 25.04.23
//

import CoreUI
import SwiftUI

struct VoteView: View {
	@EnvironmentObject var viewModel: VotesViewModel

	private var voting: Voting
	@State private var selectedEvent: Event? = nil
	@State private var presentConfirmation = false
	@State private var votedFor: VoteEvent? = nil

	init(voting: Voting) {
		self.voting = voting
		votedFor = Mocks.voteEvent
	}

	var body: some View {
		VStack(spacing: 0) {
			Text(voting.title)
				.font(.title)
				.padding(.horizontal)
				.padding(.top)

			eventList()

			if votedFor == nil {
				voteButton()
			} else {
				EmptyView()
			}
		}
	}

	func eventList() -> some View {
		ScrollView(.horizontal) {
			HStack {
				ForEach(voting.events) { event in
					VoteBandItem(event: event, choosenBand: selectedEvent == event) {
						selectEvent(event)
					}
					.frame(width: 300, height: 250)
					.padding()
				}
			}
		}
	}

	func selectEvent(_ event: Event?) {
		if selectedEvent == event {
			selectedEvent = nil
		} else {
			selectedEvent = event
		}
	}

	func voteButton() -> some View {
		Button(action: {
			presentConfirmation = true
		}) {
			Text("Stimme abgeben")
				.padding(6)
		}
		.disabled(selectedEvent == nil)
		.buttonStyle(IrfcYellowRoundedButton())
		.padding()
		.confirmationDialog("Wollen sie wirklich für abstimmen", isPresented: $presentConfirmation, titleVisibility: .visible) {
			Button("Ja", role: .destructive) {
				Task {
					guard let selectedEvent = selectedEvent else { return }
					let votedFor = VoteEvent(vote: voting, event: selectedEvent)
					let saved = await viewModel.vote(for: votedFor)

					if saved {
						self.votedFor = votedFor
					}
				}
			}
		}
	}
}

struct VoteView_Previews: PreviewProvider {
	static var previews: some View {
		VoteView(voting: Mocks.voting)
	}
}
