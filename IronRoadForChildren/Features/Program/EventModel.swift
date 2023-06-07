//
//  EventModel.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 24.04.23.
//

import Foundation

struct Event: Codable, Identifiable {
	let eventId: Int
	let title: String
	//    let pricture: Picture // add later
	let startDateTimeInUTC: Date
	let endDateTimeInUTC: Date
	let eventLocation: EventLocation
	let eventCategory: EventCategory
	let eventInfo: EventInfo

	// TODO: maybe replace with coding keys
	var id: Int {
		return eventId
	}
}

struct EventCategory: Codable {
	let eventCategoryId: Int
	let name: String
}

struct EventLocation: Codable {
	let eventLocationId: Int
	let name: String
}

struct EventInfo: Codable {
	let eventInfoId: Int
	let infoText: String
	//    let pictures: [Pictures] // add later
}

struct EventDay: Equatable {
	let id = UUID()
	let name: String
	let events: [Event]

	static func == (lhs: EventDay, rhs: EventDay) -> Bool {
		lhs.id == rhs.id
	}
}
