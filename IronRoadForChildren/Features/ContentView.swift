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
    private let irfcYellow = UIColor(.irfcYellow)
    private let irfcBlue = UIColor(.irfcBlue)

    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(.irfcBlue)
        tabBarAppearance.selectionIndicatorTintColor = UIColor.white

        let tabBar = UITabBar.appearance()
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance

        tabBar.backgroundColor = UIColor(.irfcBlue)
        tabBar.unselectedItemTintColor = UIColor.white
        tabBar.barTintColor = UIColor(.irfcBlue)
        tabBar.tintColor = UIColor(.irfcBlue)
    }

    var body: some View {
        TabView {
            NavigationView {
                ProgramView()
                    .navigationBarHidden(true)
            }
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
        }
        .accentColor(.irfcYellow)
        .tint(.irfcYellow)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("ios 16")

        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
            .previewDisplayName("ios 15")
    }
}
