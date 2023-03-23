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
                // the buttons take the whole vertical space
                .frame(maxWidth: .infinity)
                // foregroundColor needs to be black, otherwize it's blue
                .foregroundColor(.black)
                // pushes the rectangle down
                .padding(.bottom, 20)
                // the yellow underline (rectangle), when selected
                .overlay(
                    Rectangle()
                        // it's a rectangle with a height of 2
                        .frame(height: 2)
                        // color yellow if selected
                        .foregroundColor(isSelected ? Color.yellow : Color.clear)
                        // let a little space between the divider and align it to the bottom
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
