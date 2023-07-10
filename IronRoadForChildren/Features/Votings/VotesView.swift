//
//  VotesView.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 12.06.23.
//

import Foundation
import SwiftUI

struct VotesView: View {
	@StateObject var viewModel = VotesViewModel()

	var body: some View {
		if viewModel.isLoadingVotings {
			ProgressView()
		} else if let msg = viewModel.errorMsg {
			Text(msg)
		} else if viewModel.votings.isEmpty {
			Text("Derzeit gibt es noch keine Votings.")
		} else {
			ScrollView {
				ForEach(Array(viewModel.votings.enumerated()), id: \.offset) { index, voting in
					if voting.active {
						VoteView(voting: voting)
							.environmentObject(viewModel)

						if viewModel.votings.count != index + 1 {
							Divider()
								.padding([.top, .horizontal])
						}
					}
				}
			}
		}
	}
}

struct VotesView_Previews: PreviewProvider {
	static var previews: some View {
		VotesView(
			viewModel: VotesViewModel(mockVotings: Mocks.votings)
		)
	}
}
