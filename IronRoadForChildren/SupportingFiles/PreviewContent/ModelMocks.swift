//
//  ModelMocks.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 27.06.23.
//

import Foundation

struct Mocks {
	static var events: [Event] {
		return [event, event2, event3, event4]
	}

	static var categories: [EventCategory] {
		return [eventCategory, eventCategory2]
	}

	static var event: Event {
		Event(eventId: 1,
		      title: "Tattoo Event 1",
		      picture: picture,
		      startDateTimeInUTC: Date(),
		      endDateTimeInUTC: Date() + 1,
		      eventLocation: eventLocation,
		      eventCategory: eventCategory,
		      eventInfo: eventInfo)
	}

	static var event2: Event {
		Event(eventId: 2,
		      title: "Musik Event 2",
		      picture: picture,
		      startDateTimeInUTC: Date() + 3600,
		      endDateTimeInUTC: Date() + 7200,
		      eventLocation: eventLocation,
		      eventCategory: eventCategory2,
		      eventInfo: eventInfo)
	}

	static var event3: Event {
		Event(eventId: 3,
		      title: "Musik Event",
		      picture: picture,
		      startDateTimeInUTC: Date() + 36000,
		      endDateTimeInUTC: Date() + 370_000,
		      eventLocation: eventLocation,
		      eventCategory: eventCategory2,
		      eventInfo: eventInfo)
	}

	static var event4: Event {
		Event(eventId: 4,
		      title: "Musik Event",
		      picture: picture,
		      startDateTimeInUTC: Date() + 110_000,
		      endDateTimeInUTC: Date() + 120_000,
		      eventLocation: eventLocation,
		      eventCategory: eventCategory2,
		      eventInfo: eventInfo)
	}

	static var picture: Picture {
		Picture(pictureId: 1,
		        altText: "Test alt text wuhuu",
		        path: "https://www.nasa.gov/sites/default/files/thumbnails/image/spacex_dragon_june_29.jpg")
	}

	static var eventLocation: EventLocation {
		EventLocation(eventLocationId: 1, name: "Nova Rock Bühne")
	}

	static var eventCategory: EventCategory {
		EventCategory(eventCategoryId: 1, name: "Tattoo")
	}

	static var eventCategory2: EventCategory {
		EventCategory(eventCategoryId: 2, name: "Musik")
	}

	static var eventInfo: EventInfo {
		EventInfo(eventInfoId: 1, infoText: "My event info", pictures: [])
	}

	static var eventInfo2: EventInfo {
		EventInfo(eventInfoId: 2, infoText: "My event info", pictures: [picture, picture])
	}
}
