// Copyright © 2023 IRFC

import Foundation
import SwiftUI

struct VotesView: View {
	@StateObject var viewModel = VotesViewModel()

	var body: some View {
		if viewModel.isLoadingVotings {
			ProgressView()
		} else if let msg = viewModel.errorMsg {
			Text(msg)
		} else if viewModel.votings.isEmpty || viewModel.votings.filter({ $0.active }).isEmpty {
			Text("Derzeit gibt es keine Votings.")
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
