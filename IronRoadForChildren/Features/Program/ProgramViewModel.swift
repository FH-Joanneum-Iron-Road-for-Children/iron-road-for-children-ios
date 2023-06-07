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

	@Published var eventCategories: [EventCategory] = []
	@Published var isLoadingCategories = false

	@Published var error: String? = nil

	init() {
		loadEvents()
		loadCategories()
	}

	func loadEvents() {
		Task.detached { @MainActor in
			do {
				self.error = nil
				try await self.fetchEvents()
			} catch {
				self.isLoadingEvents = false
				self.error = error.localizedDescription
			}
		}
	}

	func loadCategories() {
		Task.detached { @MainActor in
			do {
				self.error = nil
				try await self.fetchCategories()
			} catch {
				self.isLoadingCategories = false
				self.error = error.localizedDescription
			}
		}
	}

	private func fetchEvents() async throws {
		isLoadingEvents = true

		let url = world.serverUrlWith(path: "/api/events")
		let (body, response) = try await URLSession.shared.dataArray(.get, from: url, responseType: Event.self)

		dayEvents = [EventDay(name: "Testday", events: body)]
		isLoadingEvents = false
	}

	private func fetchCategories() async throws {
		isLoadingCategories = true

		let url = world.serverUrlWith(path: "/api/eventCategories")
		let (body, response) = try await URLSession.shared.dataArray(.get, from: url, responseType: EventCategory.self)

		eventCategories = body
		isLoadingCategories = false
	}
}
