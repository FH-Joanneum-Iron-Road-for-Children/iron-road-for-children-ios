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

	@Published var isLoadingEvents = true

	@Published var eventDays: [EventDay] = []

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
				self.eventDays = []
			}
			return
		}

		var eventsByDays: [String: [Event]] = [:]

		allEvents.forEach { event in
			let date = world.localDate(of: event.startDateTimeInUTC)

			if eventsByDays.contains(where: { $0.key == date }) {
				eventsByDays[date]?.append(event)
			} else {
				let newEvents = [event]
				eventsByDays[date] = newEvents
			}
		}

		let eventsByDaysSorted = eventsByDays.sorted(by: {
			let lhs = world.dateStringToDate(from: $0.key) ?? Date()
			let rhs = world.dateStringToDate(from: $1.key) ?? Date()

			return lhs < rhs
		})

		var eventDays: [EventDay] = []
		eventsByDaysSorted.forEach { day in
			guard let weekday = world.localDateToWeekday(from: day.key) else { return }
			eventDays.append(EventDay(name: weekday, events: day.value.sorted(by: { $0.startDateTimeInUTC < $1.startDateTimeInUTC })))
		}

		withAnimation {
			self.eventDays = eventDays
		}
	}
}
