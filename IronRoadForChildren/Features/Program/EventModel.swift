//
//  EventModel.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 24.04.23.
//

import Foundation

struct Event: Codable {
	let eventId: Int
	let title: String
	let startDateTimeInUTC: Int
	let endDateTimeInUTC: Int
	let eventLocation: EventLocation?
}

struct EventLocation: Codable {
	let eventLocationId: Int
	let name: String
}
