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

	private var allEvents: [Event] = [] {
		didSet {
			separateEventToDays()
		}
	}

	@Published var dayEvents: [EventDay] = []
	@Published var isLoadingEvents = false

	@Published var eventCategories: [EventCategory] = []
	@Published var isLoadingCategories = false
	@Published var filteredCategorie: EventCategory? = nil {
		didSet {
			separateEventToDays()
		}
	}

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
		let (body, _) = try await URLSession.shared.dataArray(.get, from: url, responseType: Event.self)

		allEvents = body

		withAnimation {
			isLoadingEvents = false
		}
	}

	private func fetchCategories() async throws {
		isLoadingCategories = true

		let url = world.serverUrlWith(path: "/api/eventCategories")
		let (body, _) = try await URLSession.shared.dataArray(.get, from: url, responseType: EventCategory.self)

		withAnimation {
			eventCategories = body
			isLoadingCategories = false
		}
	}

	private func separateEventToDays() {
		withAnimation {
			dayEvents = [EventDay(name: "Testday", events: allEvents)]
		}

		// TODO: Add logic here

		applyCategorieFilter()
	}

	private func applyCategorieFilter() {
		guard let filteredCategorie = filteredCategorie else { return }

		var days = dayEvents

		for (index, day) in days.enumerated() {
			days[index].events = day.events.filter { $0.eventCategory.eventCategoryId == filteredCategorie.eventCategoryId }
		}

		withAnimation {
			dayEvents = days
		}
	}
}
