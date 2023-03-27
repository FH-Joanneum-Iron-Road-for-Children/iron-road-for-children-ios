//
//  ContentView.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 08.03.23.
//

import ExampleMVVM
import SwiftUI

struct ContentView: View {
    init() {
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.backgroundColor = UIColor.yellow
        tabBarAppearance.unselectedItemTintColor = UIColor.black
    }

    var body: some View {
        NavigationView {
            TabView {
                ExampleView()
                    .tabItem {
                        Label("Example", systemImage: "list.dash")
                    }

                ProgramView()
                    .tabItem {
                        Label("Program", systemImage: "calendar")
                    }

                VoteView()
                    .tabItem {
                        Label("Vote", systemImage: "tray")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
