//
//  FilterRowView.swift
//  IronRoadForChildren
//
//  Created by Robert Zavaczki on 05.06.23.
//

import SwiftUI

struct FiltersRowView: View {
	let filterCategories = ["Musik", "Tattoo", "Ausfahrt", "Essen"]
	@State private var selectedFilter: String?

	var body: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack {
				ForEach(filterCategories, id: \.self) { category in
					FilterButtonView(buttonText: category, isActive: Binding(
						get: { selectedFilter == category },
						set: { if $0 { selectedFilter = category } }
					))
				}
			}
		}
	}
}

struct FiltersRowView_Previews: PreviewProvider {
	static var previews: some View {
		FiltersRowView()
	}
}
