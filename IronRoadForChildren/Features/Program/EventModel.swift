// Copyright © 2023 IRFC

import Foundation

struct Event: Codable, Equatable, Identifiable {
	let eventId: Int
	let title: String
	let picture: Picture
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
	let pictures: [Picture]

	var id: Int {
		return eventInfoId
	}
}

struct EventDay: Equatable, Identifiable {
	let id = UUID()
	let name: String
	var events: [Event]
	var date: Date {
		events.first!.startDateTimeInUTC
	}
}

struct Picture: Codable, Equatable, Identifiable {
	let pictureId: Int
	let altText: String
	let path: String

	var id: Int {
		return pictureId
	}
}
