//
//  World.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 24.04.23.
//

import Foundation
import KeychainWrapper

var world = World()

struct World {
	private let config = Config()

	let keychain = KeychainWrapper()

	func serverUrlWith(path: String) -> URL {
		var components = config.serverURLComponents
		components.path = path
		return components.url!
	}

	func localTimeHourMinute(of utcDate: Date) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone.current // Use the device's current time zone
		dateFormatter.dateFormat = "HH:mm" // Format the date and time as desired

		return dateFormatter.string(from: utcDate)
	}

	func localDate(of utcDate: Date) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone.current // Use the device's current time zone
		dateFormatter.dateFormat = "dd.MM.yyyy" // Format the date and time as desired

		return dateFormatter.string(from: utcDate)
	}

	func localDateToWeekday(from dateString: String) -> String? {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd.MM.yyyy"
		guard let date = formatter.date(from: dateString) else {
			print("Invalid date format")
			return nil
		}

		let calendar = Calendar.current
		let weekday = calendar.component(.weekday, from: date)

		let formatterWithLocale = DateFormatter()
		formatterWithLocale.locale = Locale(identifier: "de_DE") // TODO: change when moving to localizable
		let weekdayName = formatterWithLocale.weekdaySymbols[weekday - 1]

		return weekdayName
	}

	func dateStringToDate(from dateString: String) -> Date? {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd.MM.yyyy"

		guard let date = formatter.date(from: dateString) else {
			print("Invalid date format")
			return nil
		}

		return date
	}
}
