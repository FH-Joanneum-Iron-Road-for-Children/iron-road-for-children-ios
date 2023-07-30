// Copyright © 2023 IRFC

import Foundation
import Networking
import SwiftUI

class ProgramViewModel: ObservableObject {
	@Published var selectedTab = 0

	private var allEvents: [Event] = []

	@Published var isLoadingEvents = true

	@Published var eventDays: [EventDay] = []

	@Published var eventCategories: [EventCategory] = []
	@Published var filteredCategorie: EventCategory? = nil

	@Published var errorMessage: String? = nil

	init(eventMocks: [Event]? = nil,
	     eventCategoriesMocks: [EventCategory]? = nil)
	{
		if let eventMocks = eventMocks,
		   let eventCategoriesMocks = eventCategoriesMocks
		{
			allEvents = eventMocks
			eventCategories = eventCategoriesMocks
			isLoadingEvents = false

			Task {
				await self.separateEventToDays()
			}

			return
		}

		Task {
			await loadEvents()
		}
	}

	@MainActor
	func loadEvents() async {
		do {
			withAnimation {
				isLoadingEvents = true
			}

			errorMessage = nil
			try await fetchCategories()
			try await fetchEvents()
			await separateEventToDays()

			withAnimation {
				isLoadingEvents = false
			}
		} catch {
			withAnimation {
				isLoadingEvents = false
				self.errorMessage = error.localizedDescription
			}
		}
	}

	@MainActor
	private func fetchEvents() async throws {
		let url = world.serverUrlWith(path: "/api/events")
		let (body, _) = try await URLSession.shared.dataArray(.get, from: url, responseType: Event.self)

		allEvents = body
	}

	@MainActor
	private func fetchCategories() async throws {
		let url = world.serverUrlWith(path: "/api/eventCategories")
		let (body, _) = try await URLSession.shared.dataArray(.get, from: url, responseType: EventCategory.self)

		eventCategories = body
	}

	@MainActor
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
