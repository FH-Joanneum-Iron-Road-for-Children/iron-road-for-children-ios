// Copyright © 2023 IRFC

import Foundation

struct Mocks {
	static var votings: [Voting] {
		return [voting]
	}

	static var voting: Voting {
		return Voting(
			votingId: 1,
			title: "Bester Sänger",
			active: true,
			events: [event2, event3, event4]
		)
	}

	static var voteEvent: VoteEvent {
		return VoteEvent(voteId: 1, eventId: 1)
	}

	static var events: [Event] {
		return [event, event2, event3, event4]
	}

	static var categories: [EventCategory] {
		return [eventCategory, eventCategory2]
	}

	static var event: Event {
		Event(
			eventId: 1,
			title: "Tattoo Event 1",
			picture: picture,
			startDateTimeInUTC: Date(),
			endDateTimeInUTC: Date() + 1,
			eventLocation: eventLocation,
			eventCategory: eventCategory,
			eventInfo: eventInfo2
		)
	}

	static var event2: Event {
		Event(
			eventId: 2,
			title: "Musik Event 2",
			picture: picture2,
			startDateTimeInUTC: Date() + 3600,
			endDateTimeInUTC: Date() + 7200,
			eventLocation: eventLocation,
			eventCategory: eventCategory2,
			eventInfo: eventInfo
		)
	}

	static var event3: Event {
		Event(
			eventId: 3,
			title: "Musik Event",
			picture: picture,
			startDateTimeInUTC: Date() + 36000,
			endDateTimeInUTC: Date() + 370_000,
			eventLocation: eventLocation,
			eventCategory: eventCategory2,
			eventInfo: eventInfo
		)
	}

	static var event4: Event {
		Event(
			eventId: 4,
			title: "Musik Event",
			picture: picture2,
			startDateTimeInUTC: Date() + 110_000,
			endDateTimeInUTC: Date() + 120_000,
			eventLocation: eventLocation,
			eventCategory: eventCategory2,
			eventInfo: eventInfo
		)
	}

	static var picture: Picture {
		Picture(
			pictureId: 1,
			altText: "Test alt text wuhuu",
			path: "https://www.nasa.gov/sites/default/files/thumbnails/image/spacex_dragon_june_29.jpg"
		)
	}

	static var picture2: Picture {
		Picture(
			pictureId: 2,
			altText: "Test alt text wuhuu",
			path: "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/afrc2021-0149-02_orig.jpg"
		)
	}

	static var eventLocation: EventLocation {
		EventLocation(
			eventLocationId: 1,
			name: "Nova Rock Bühne"
		)
	}

	static var eventCategory: EventCategory {
		EventCategory(
			eventCategoryId: 1,
			name: "Tattoo"
		)
	}

	static var eventCategory2: EventCategory {
		EventCategory(
			eventCategoryId: 2,
			name: "Musik"
		)
	}

	static var eventInfo: EventInfo {
		EventInfo(
			eventInfoId: 1,
			infoText: "My event info",
			pictures: []
		)
	}

	static var eventInfo2: EventInfo {
		EventInfo(
			eventInfoId: 2,
			infoText: "My event info",
			pictures: [picture, picture]
		)
	}
}
