//
//  VoteView.swift
//  IronRoadForChildren
//
//  Created by Daniel Zellner on 25.04.23
//

import CoreUI
import SnapToScroll
import SwiftUI

struct VoteView: View {
	@State private var index = 0
	private var voting: Voting

	@EnvironmentObject var viewModel: VoteViewModel

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
						VoteBandItem(name: event.title,
						             description: event.eventInfo.infoText)
							.frame(width: 300, height: 250)
							.padding()
					}
				}
			}

			HStack {
				ForEach(0 ..< voting.events.count, id: \.self) { index in
					Circle()
						.fill(index == self.index ? Color.irfcYellow : Color.irfcYellow.opacity(0.5))
						.frame(width: 10, height: 10)
				}
			}
			.padding(.bottom)

			Button(action: {
				Task {
					await viewModel.vote()
				}
			}) {
				Text("Stimme abgeben")
					.padding(6)
			}
			.buttonStyle(IrfcYellowRoundedButton())
			.padding()
		}
	}
}
