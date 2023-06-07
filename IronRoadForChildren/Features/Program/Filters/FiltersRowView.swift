//
//  FilterRowView.swift
//  IronRoadForChildren
//
//  Created by Robert Zavaczki on 05.06.23.
//

import SwiftUI

struct FiltersRowView: View {
	@EnvironmentObject var programViewModel: ProgramViewModel

	var body: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack {
				ForEach(programViewModel.eventCategories, id: \.eventCategoryId) { category in
					FilterButtonView(
						buttonText: category.name,
						isActive: category.eventCategoryId == programViewModel.filteredCategorie?.eventCategoryId,
						click: {
							programViewModel.filteredCategorie = category
						}
					)
				}
			}
		}
	}
}

struct FiltersRowView_Previews: PreviewProvider {
	static var previews: some View {
		FiltersRowView()
			.environmentObject(ProgramViewModel())
	}
}
