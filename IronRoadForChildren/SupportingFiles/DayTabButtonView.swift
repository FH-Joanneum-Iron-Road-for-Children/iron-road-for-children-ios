//
//  DayTabButtonView.swift
//  IronRoadForChildren
//
//  Created by Robert Zavaczki on 23.03.23.
//

import SwiftUI

struct DayTabButtonView: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                // .font(.headline)
                .foregroundColor(.black)
                .padding(.bottom, 25)
                // .background(Color(.systemBackground))
                .overlay(
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(isSelected ? Color.yellow : Color.clear)
                        .padding(.bottom, 2), alignment: .bottom
                )
        }
    }
}

struct DayTabButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DayTabButtonView(title: "Tag", isSelected: true, action: {})
    }
}
