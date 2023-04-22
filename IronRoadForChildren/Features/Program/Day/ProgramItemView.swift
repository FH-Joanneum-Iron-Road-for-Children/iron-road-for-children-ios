//
//  ProgramItemView.swift
//  IronRoadForChildren
//
//  Created by Robert Zavaczki on 18.04.23.
//

import SwiftUI

struct ProgramItemView: View {
	var body: some View {
		Rectangle()
			.cornerRadius(10)
			.frame(height: 80)
			.foregroundColor(.pink.opacity(0.03))
			.overlay(
				RoundedRectangle(cornerRadius: 20)
					.strokeBorder(Color.gray, lineWidth: 1)
			)
			.overlay(
				HStack {
					Image(systemName: "person.fill")
						.resizable()
						.frame(height: 80)
						.aspectRatio(1, contentMode: .fit)
					VStack(alignment: .leading, spacing: 5) {
						Text("THE BAND THAT HAS A VERY LONG NAME")
							.fontWeight(.semibold)
							.lineSpacing(5)
							.font(.system(size: 16))
						Text("STAGE HAS ALSO A LONG NAME")
							.lineLimit(1)
							.font(.system(size: 15))
					}
					// .background(Color.red)
					Spacer()
					Text("16:00 - 16:40")
						.font(.system(size: 16))
						.fontWeight(.semibold)
						.padding(.trailing, 5)
						.lineLimit(1)
						.fixedSize(horizontal: true, vertical: false)
				}
				.padding(.horizontal, 10)
			)
	}
}

struct ProgramItemView_Previews: PreviewProvider {
	static var previews: some View {
		ProgramItemView()
	}
}