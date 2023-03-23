//
//  ProgramView.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 15.03.23.
//

import SwiftUI

struct ProgramView: View {
    @StateObject var viewModel = ProgramViewModel()

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text("Programm")
                    .font(.title)
                    .padding(.leading, 20)
                    .padding(.bottom, 25)
                Spacer()
            }
            // upper Tabbar to select the days
            HStack {
                DayTabButtonView(title: "Samstag", isSelected: viewModel.selectedTab == 0) {
                    viewModel.selectedTab = 0
                }
                DayTabButtonView(title: "Sonntag", isSelected: viewModel.selectedTab == 1) {
                    viewModel.selectedTab = 1
                }
            }
            .frame(height: 30)

            // Subview based on selected tab
            DayView(contents: viewModel.programText)
        }
        .padding(.vertical)
    }
}

struct ProgramView_Previews: PreviewProvider {
    static var previews: some View {
        ProgramView()
    }
}
