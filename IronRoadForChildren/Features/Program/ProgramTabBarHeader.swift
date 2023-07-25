// Copyright © 2023 IRFC

import SwiftUI

struct ProgramTabBarHeader: View {
	@Namespace var namespace

	@Binding var currentTab: Int
	var tabBarOptions: [ProgramTabBarOption]

	var body: some View {
		VStack(spacing: 0) {
			HStack {
				ForEach(
					Array(zip(self.tabBarOptions.indices, self.tabBarOptions)),
					id: \.0
				) { index, option in
					ProgramTabBarItem(
						currentTab: self.$currentTab,
						namespace: namespace.self,
						tabBarItemName: option.name,
						tab: index,
						date: option.date
					)
				}
			}
			.frame(maxWidth: .infinity)
			.frame(height: 30)
			.padding(.horizontal)
			.padding(.bottom, 10)
			.padding(.top)

			Divider()
		}
	}
}

struct ProgramTabbarHeader_Previews: PreviewProvider {
	static var previews: some View {
		ProgramTabBarHeader(
			currentTab: .constant(1), tabBarOptions: [
				ProgramTabBarOption(name: "me", date: Date()),
				ProgramTabBarOption(name: "other", date: Date().addingTimeInterval(24 * 60 * 60)),
				ProgramTabBarOption(name: "other", date: nil),
			]
		)
	}
}

struct ProgramTabBarOption {
	let name: String
	let date: Date?
}
