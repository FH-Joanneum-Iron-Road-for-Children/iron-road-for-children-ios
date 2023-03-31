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

        updateTabBarItemAppearance(appearance: tabBarAppearance.compactInlineLayoutAppearance)
        updateTabBarItemAppearance(appearance: tabBarAppearance.inlineLayoutAppearance)
        updateTabBarItemAppearance(appearance: tabBarAppearance.stackedLayoutAppearance)

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

    private func updateTabBarItemAppearance(appearance: UITabBarItemAppearance) {
        appearance.selected.iconColor = irfcYellow
        appearance.normal.iconColor = .white
        appearance.selected.badgeBackgroundColor = .white
    }
}

extension View {
    func applyIrfcToolbarTheme() -> some View {
        if #available(iOS 16, *) {
            return self.modifier(TabbarModifier())
        } else {
            return modifier(TabbarModifierOld())
        }
    }
}

@available(iOS 16, *)
private struct TabbarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbarBackground(Color.irfcBlue, for: .tabBar)
    }
}

/// Needed for iOS 15
@available(iOS, deprecated: 16, obsoleted: 16, message: "We no longer need this tabbar theming in iOS 16 and up")
private struct TabbarModifierOld: ViewModifier {
    func body(content: Content) -> some View {
        content.onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = UIColor(.irfcBlue)

//            updateTabBarItemAppearance(appearance: tabBarAppearance.compactInlineLayoutAppearance)
//            updateTabBarItemAppearance(appearance: tabBarAppearance.inlineLayoutAppearance)
//            updateTabBarItemAppearance(appearance: tabBarAppearance.stackedLayoutAppearance)
//
            let tabBar = UITabBar.appearance()
            tabBar.standardAppearance = tabBarAppearance
            tabBar.scrollEdgeAppearance = tabBarAppearance

            tabBar.backgroundColor = UIColor(.irfcBlue)
            tabBar.unselectedItemTintColor = UIColor.white
            tabBar.barTintColor = UIColor(.irfcBlue)
            tabBar.tintColor = UIColor(.irfcBlue)
        }
    }
//
//    private func updateTabBarItemAppearance(appearance: UITabBarItemAppearance) {
//        appearance.selected.iconColor = yellow
//        appearance.normal.iconColor = .white
//    }
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
