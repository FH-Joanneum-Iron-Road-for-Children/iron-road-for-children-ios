//
//  ProgramTabBarHeader.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 27.03.23.
//

import SwiftUI

struct ProgramTabBarHeader: View {
	@Namespace var namespace

	@Binding var currentTab: Int
	var tabBarOptions: [String]

	var body: some View {
		VStack(spacing: 0) {
			HStack {
				ForEach(
					Array(zip(self.tabBarOptions.indices, self.tabBarOptions)),
					id: \.0
				) { index, name in
					ProgramTabBarItem(
						currentTab: self.$currentTab,
						namespace: namespace.self,
						tabBarItemName: name,
						tab: index
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
			currentTab: .constant(1), tabBarOptions: ["me", "other"]
		)
	}
}
