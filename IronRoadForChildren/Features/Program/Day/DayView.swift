//
//  DayView.swift
//  IronRoadForChildren
//
//  Created by Robert Zavaczki on 23.03.23.
//

import SwiftUI

struct DayView: View {
	var body: some View {
		VStack {
			Divider()
			ScrollView {
				ForEach(0 ..< 10) { _ in
					NavigationLink(destination: ProgramItemDelailView()) {
						ProgramItemView()
							.padding(.top, 15)
					}
				}
			}
		}
		.padding(.horizontal, 20)
	}
}

struct DayView_Previews: PreviewProvider {
	static var previews: some View {
		DayView()
	}
}
