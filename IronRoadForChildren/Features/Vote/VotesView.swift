//
//  VotesView.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 12.06.23.
//

import Foundation
import SwiftUI

struct VotesView: View {
	@StateObject var viewModel = VoteViewModel()

	var body: some View {
		if viewModel.isLoadingVotings {
			ProgressView()
		} else if let msg = viewModel.errorMsg {
			Text(msg)
		} else if viewModel.votings.isEmpty {
			Text("Derzeit gibt es noch keine Votings.")
		} else {
			ScrollView {
				ForEach(viewModel.votings, id: \.votingId) { voting in
					VoteView(voting: voting)
						.environmentObject(viewModel)
				}
			}
		}
	}
}

struct VotesView_Previews: PreviewProvider {
	static var previews: some View {
		VotesView()
	}
}
