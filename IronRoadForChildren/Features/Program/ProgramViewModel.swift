//
//  ProgramViewModel.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 15.03.23.
//

import Foundation
import Networking

@MainActor
class ProgramViewModel: ObservableObject {
	@Published var selectedTab = 0

	@Published var events: [Event] = []
	@Published var isLoadingEvents = false

	@Published var error: String = ""

	init() {}

	private func fetchEvents() async throws {
		isLoadingEvents = true

		let url = world.serverUrlWith(path: "/api/events")
		let (body, _) = try await URLSession.shared.dataArray(.get, from: url, responseType: Event.self)

		events = body
		isLoadingEvents = false
	}
}
