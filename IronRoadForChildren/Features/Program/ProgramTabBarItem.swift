// Copyright © 2023 IRFC

import SwiftUI

struct ProgramTabBarItem: View {
	@Binding var currentTab: Int
	let namespace: Namespace.ID
	var tabBarItemName: String
	var tab: Int
	var date: Date?

	var body: some View {
		Button {
			self.currentTab = tab
		} label: {
			VStack(spacing: 0) {
				HStack {
					Spacer()

					VStack {
						HStack {
							Text(tabBarItemName)
								.font(.body)
						}

						HStack {
							if let date = date {
								Text(world.localDate(of: date))
									.font(.caption)
							}
						}
					}

					Spacer()
				}

				Spacer()

				if currentTab == tab {
					Color.yellow
						.frame(height: 2)
						.matchedGeometryEffect(
							id: "underline",
							in: namespace,
							properties: .frame
						)
				} else {
					Color.clear.frame(height: 2)
				}
			}
			.animation(.spring(), value: self.currentTab)
		}
		.buttonStyle(.plain)
		.padding(0)
	}
}
