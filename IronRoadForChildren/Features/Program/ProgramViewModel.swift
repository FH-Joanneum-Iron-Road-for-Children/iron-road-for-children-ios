//
//  ProgramViewModel.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 15.03.23.
//

import Foundation

@MainActor
class ProgramViewModel: ObservableObject {
    @Published var selectedTab = 0

    var programText: String {
        return selectedTab == 0 ? "Samstag Programm" : "Sonntag Programm"
    }
}
