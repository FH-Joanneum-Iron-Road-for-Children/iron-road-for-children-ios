// Copyright © 2025 IRFC

import Combine
import Foundation

class CountdownViewModel: ObservableObject {
	@Published var days: Int = 9
	@Published var hours: Int = 21
	@Published var minutes: Int = 34
	@Published var seconds: Int = 12

	private var cancellable: AnyCancellable?

	init() {
		// Target date - June 19, 2025
		let targetDate = Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 19)) ?? Date()

		// Update timer every second
		cancellable = Timer.publish(every: 1, on: .main, in: .common)
			.autoconnect()
			.sink { [weak self] _ in
				self?.updateCountdown(to: targetDate)
			}

		// Initial update
		updateCountdown(to: targetDate)
	}

	private func updateCountdown(to targetDate: Date) {
		let calendar = Calendar.current
		let now = Date()

		guard targetDate > now else {
			// Event has started
			days = 0
			hours = 0
			minutes = 0
			seconds = 0
			return
		}

		let components = calendar.dateComponents([.day, .hour, .minute, .second], from: now, to: targetDate)

		days = components.day ?? 0
		hours = components.hour ?? 0
		minutes = components.minute ?? 0
		seconds = components.second ?? 0
	}
}
