//
//  ProgramView.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 15.03.23.
//

import SwiftUI

struct ProgramView: View {
    @StateObject var viewModel = ProgramViewModel()

    var titles = ["Samstag", "Sonntag"]
    @State var selectedTab: Int = 0

    var body: some View {
        VStack {
            ProgramTabBarHeader(
                currentTab: $selectedTab,
                tabBarOptions: titles
            )

            TabView(selection: $selectedTab) {
                DayView(contents: "Samstag Programm")
                    .tag(0)

                DayView(contents: "Sonntag Programm")
                    .tag(1)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut(duration: 0.3), value: selectedTab)
        }
    }
}

struct ProgramView_Previews: PreviewProvider {
    static var previews: some View {
        ProgramView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("ios 16")

        ProgramView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
            .previewDisplayName("ios 15")
    }
}
