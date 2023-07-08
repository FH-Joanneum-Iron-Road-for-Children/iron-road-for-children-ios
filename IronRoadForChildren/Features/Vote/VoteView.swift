//
//  VoteView.swift
//  IronRoadForChildren
//
//  Created by Daniel Zellner on 25.04.23
//

import CoreUI
import SwiftUI

struct VoteView: View {
	@EnvironmentObject var viewModel: VoteViewModel

	private var voting: Voting
	@State private var selectedEvent: Event? = nil
	@State private var presentConfirmation = false

	init(voting: Voting) {
		self.voting = voting
	}

	var body: some View {
		VStack(spacing: 0) {
			Text(voting.title)
				.font(.title)
				.padding(.horizontal)
				.padding(.top)

			ScrollView(.horizontal) {
				HStack {
					ForEach(voting.events) { event in
						VoteBandItem(event: event, choosenBand: selectedEvent == event) {
							if selectedEvent == event {
								selectedEvent = nil
							} else {
								selectedEvent = event
							}
						}
						.frame(width: 300, height: 250)
						.padding()
					}
				}
			}

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
						guard let id = selectedEvent?.id else { return }
						await viewModel.vote(for: id)
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
