//
//  EventModel.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 24.04.23.
//

import Foundation

struct Event: Codable, Equatable, Identifiable {
	let eventId: Int
	let title: String
	//    let pricture: Picture // add later
	let startDateTimeInUTC: Date
	let endDateTimeInUTC: Date
	let eventLocation: EventLocation
	let eventCategory: EventCategory
	let eventInfo: EventInfo

	var id: Int {
		return eventId
	}
}

struct EventCategory: Codable, Equatable, Identifiable {
	let eventCategoryId: Int
	let name: String

	var id: Int {
		return eventCategoryId
	}
}

struct EventLocation: Codable, Equatable, Identifiable {
	let eventLocationId: Int
	let name: String

	var id: Int {
		return eventLocationId
	}
}

struct EventInfo: Codable, Equatable, Identifiable {
	let eventInfoId: Int
	let infoText: String
	//    let pictures: [Pictures] // add later

	var id: Int {
		return eventInfoId
	}
}

struct EventDay: Equatable, Identifiable {
	let id = UUID()
	let name: String
	var events: [Event]
}
