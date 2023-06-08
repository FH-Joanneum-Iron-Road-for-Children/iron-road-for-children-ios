//
//  ProgramViewModel.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 15.03.23.
//

import Foundation
import Networking
import SwiftUI

@MainActor
class ProgramViewModel: ObservableObject {
	@Published var selectedTab = 0

	private var allEvents: [Event] = []

	@Published var isLoadingEvents = false

	@Published var dayEvents: [EventDay] = []
	@Published var eventCategories: [EventCategory] = []
	@Published var filteredCategorie: EventCategory? = nil

	@Published var error: String? = nil

	init() {
		loadEvents()
	}

	func loadEvents() {
		Task.detached { @MainActor in
			do {
				withAnimation {
					self.isLoadingEvents = true
				}

				self.error = nil
				try await self.fetchCategories()
				try await self.fetchEvents()
				await self.separateEventToDays()

				withAnimation {
					self.isLoadingEvents = false
				}
			} catch {
				withAnimation {
					self.isLoadingEvents = false
					self.error = error.localizedDescription
				}
			}
		}
	}

	private func fetchEvents() async throws {
		let url = world.serverUrlWith(path: "/api/events")
		let (body, _) = try await URLSession.shared.dataArray(.get, from: url, responseType: Event.self)

		allEvents = body
	}

	private func fetchCategories() async throws {
		let url = world.serverUrlWith(path: "/api/eventCategories")
		let (body, _) = try await URLSession.shared.dataArray(.get, from: url, responseType: EventCategory.self)

		eventCategories = body
	}

	private func separateEventToDays() async {
		let allEvents = allEvents

		guard !allEvents.isEmpty else {
			withAnimation {
				self.dayEvents = []
			}
			return
		}

		// TODO: Add logic here
		let dayEvents = [EventDay(name: "Testday", events: allEvents)]

		guard let filteredCategorie = filteredCategorie else {
			withAnimation {
				self.dayEvents = dayEvents
			}
			return
		}

		var days = dayEvents

		for (index, day) in dayEvents.enumerated() {
			days[index].events = day.events.filter { $0.eventCategory.eventCategoryId == filteredCategorie.eventCategoryId }
		}

		withAnimation {
			self.dayEvents = days
		}
	}
}
