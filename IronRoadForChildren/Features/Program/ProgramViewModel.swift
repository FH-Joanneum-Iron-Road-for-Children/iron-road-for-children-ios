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

	@Published var dayEvents: [EventDay] = []
	@Published var isLoadingEvents = false

	@Published var eventsError: String? = nil

	init() {
		loadEvents()
	}

	func loadEvents() {
		Task.detached { @MainActor in
			do {
				self.eventsError = nil
				try await self.fetchEvents()
			} catch {
				self.isLoadingEvents = false
				self.eventsError = error.localizedDescription
			}
		}
	}

	private func fetchEvents() async throws {
		isLoadingEvents = true

		let url = world.serverUrlWith(path: "/api/events")
		let (body, response) = try await URLSession.shared.dataArray(.get, from: url, responseType: Event.self)

		guard response.statusCode == 200 else {
			eventsError = "Daten konnten nicht geladen werden"
			isLoadingEvents = false
			return
		}

		dayEvents = [EventDay(name: "Testday", events: body)]
		isLoadingEvents = false
	}
}
