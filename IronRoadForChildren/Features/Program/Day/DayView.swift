//
//  DayView.swift
//  IronRoadForChildren
//
//  Created by Robert Zavaczki on 23.03.23.
//

import SwiftUI

struct DayView: View {
    var contents: String

    var body: some View {
        VStack {
            Divider()
            Spacer()
            Text(contents)
            Spacer()
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(contents: "Tagesprogramm")
    }
}
