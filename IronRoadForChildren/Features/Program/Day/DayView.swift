//
//  DayView.swift
//  IronRoadForChildren
//
//  Created by Robert Zavaczki on 23.03.23.
//

import SwiftUI

struct DayView: View {
	var body: some View {
		ScrollView {
			VStack {
				Divider()
				ForEach(0 ..< 10) { _ in
					NavigationLink(destination: ProgramItemDelailView()) {
						ProgramItemView()
							.padding(.top, 16)
							.padding(.horizontal, 24)
					}
				}
			}
			.padding(.bottom, 16)
		}
	}
}

struct DayView_Previews: PreviewProvider {
	static var previews: some View {
		DayView()
	}
}
