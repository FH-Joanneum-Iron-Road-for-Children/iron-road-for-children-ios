//
//  VoteView.swift
//  IronRoadForChildren
//
//  Created by Daniel Zellner on 25.04.23
//

import CoreUI
import SwiftUI

struct VoteView: View {
	@EnvironmentObject private var votesViewModel: VotesViewModel
	@StateObject private var viewModel: VoteViewModel

	@State private var selectedEvent: Event? = nil
	@State private var presentConfirmation = false

	init(voting: Voting) {
		_viewModel = StateObject(wrappedValue: VoteViewModel(voting: voting))
	}

	var body: some View {
		VStack(spacing: 0) {
			votingTitle()

			eventList()

			if viewModel.votedFor == nil {
				voteButton()
			} else {
				alreadyVotedError()
			}

			error()
		}
	}

	// MARK: SwiftUI element functions

	func votingTitle() -> some View {
		Text(viewModel.voting.title)
			.font(.title)
			.padding(.horizontal)
			.padding(.top)
	}

	func eventList() -> some View {
		ScrollView(.horizontal) {
			HStack {
				ForEach(viewModel.voting.events) { event in
					VoteItem(
						event: event,
						choosenEvent: isChoosenEvent(event),
						clickable: viewModel.votedFor == nil && !viewModel.isLoading
					) {
						selectEvent(event)
					}
					.frame(width: 300, height: 250)
					.padding()
				}
			}
		}
	}

	@ViewBuilder
	func voteButton() -> some View {
		Button(action: {
			presentConfirmation = true
		}) {
			if viewModel.isLoading {
				ProgressView()
					.padding(6)
			} else {
				Text("Stimme abgeben")
					.padding(6)
			}
		}
		.disabled(selectedEvent == nil || viewModel.isLoading)
		.buttonStyle(IrfcYellowRoundedButton())
		.padding()
		.confirmationDialog("Wollen sie wirklich für \(selectedEvent?.title ?? "unbekannt") abstimmen?", isPresented: $presentConfirmation, titleVisibility: .visible) {
			Button("Ja", role: .destructive) {
				Task {
					guard let selectedEvent = selectedEvent else { return }
					await viewModel.vote(for: selectedEvent)
				}
			}
		}
	}

	func alreadyVotedError() -> some View {
		Text("Sie haben in dieser Kategorie bereits abgestimmt.")
			.multilineTextAlignment(.center)
			.font(.caption)
	}

	@ViewBuilder
	func error() -> some View {
		if viewModel.voteError != nil {
			Text("Es ist ein Fehler aufgetreten, bitte stimmen Sie erneut ab.")
				.multilineTextAlignment(.leading)
				.font(.caption)
				.foregroundColor(.red)
				.padding()
		}
	}

	// MARK: functions

	func selectEvent(_ event: Event?) {
		guard viewModel.votedFor == nil else { return }

		if selectedEvent == event {
			selectedEvent = nil
		} else {
			selectedEvent = event
		}
	}

	func isChoosenEvent(_ event: Event?) -> Bool {
		if let eventId = viewModel.votedFor?.eventId,
		   event?.id == eventId
		{
			return true
		}

		if event?.id == selectedEvent?.id {
			return true
		}

		return false
	}
}

struct VoteView_Previews: PreviewProvider {
	static var previews: some View {
		VoteView(voting: Mocks.voting)
	}
}
