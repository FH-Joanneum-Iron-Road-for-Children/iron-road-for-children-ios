//
//  VoteView.swift
//  IronRoadForChildren
//
//  Created by Daniel Zellner on 25.04.23
//

import SwiftUI

struct VoteView: View {
	@State private var index = 0

	var body: some View {
		ScrollView {
			VStack {
				VoteHeader()

				TabView(selection: $index) {
					ForEach(0 ..< 10, id: \.self) { _ in
						VoteBandItem()
					}
				}
				.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

				HStack {
					ForEach(0 ..< 10, id: \.self) { index in
						Circle()
							.fill(index == self.index ? Color.irfcYellow : Color.irfcYellow.opacity(0.5))
							.frame(width: 10, height: 10)
					}
				}

				Button(action: {}) {
					Text("Stimme abgeben").padding()
				}
				.background(Color.irfcYellow)
				.clipShape(Capsule())
				.padding()
			}
		}
	}
}

struct VoteView_Previews: PreviewProvider {
	static var previews: some View {
		VoteView()
	}
}
