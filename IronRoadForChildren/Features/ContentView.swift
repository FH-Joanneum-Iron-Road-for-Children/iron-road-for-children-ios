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
            ProgramView()
                .tabItem {
                    Label("Program", image: "program")
                }

            VoteView()
                .tabItem {
                    Label("Vote", image: "vote")
                }

            MapView()
                .tabItem {
                    Label("Map", image: "map")
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
        .accentColor(.irfcYellow)
        .tint(.irfcYellow)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
