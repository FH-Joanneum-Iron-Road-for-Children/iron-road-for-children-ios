//
//  ContentView.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 08.03.23.
//

import CoreUI
import ExampleMVVM
import SwiftUI

struct ContentView: View {
    init() {
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.backgroundColor = UIColor(.irfcBlue)
        tabBarAppearance.unselectedItemTintColor = UIColor.white
    }

    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Label("Map", image: "map")
                }

            ProgramView()
                .tabItem {
                    Label("Program", image: "program")
                }

            VoteView()
                .tabItem {
                    Label("Vote", image: "vote")
                }

            MoreView()
                .tabItem {
                    Label("More", systemImage: "ellipsis")
                }

            ExampleView()
                .tabItem {
                    Label("CoreUI", systemImage: "list.dash")
                }
        }
        .tint(.irfcYellow)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
