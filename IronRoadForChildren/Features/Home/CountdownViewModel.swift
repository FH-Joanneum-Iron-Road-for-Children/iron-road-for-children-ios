// Copyright © 2025 IRFC

import Combine
import Foundation

class CountdownViewModel: ObservableObject {
	@Published var days: Int = 0
	@Published var hours: Int = 0
	@Published var minutes: Int = 0
	@Published var seconds: Int = 0

	private var timerCancellable: AnyCancellable?
	private var fetchCancellable: AnyCancellable?
	private var targetDate: Date?

	init() {
		// Target date - June 19, 2025
		fetchCountdown()
	}

	private func fetchCountdown() {
		let url = world.serverUrlWith(path: "/api/countdowns")
		fetchCancellable = URLSession.shared.dataTaskPublisher(for: url)
			.map { $0.data }
			.decode(type: [CountdownResponse].self, decoder: JSONDecoder())
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { _ in
				// Handle error if needed
			}, receiveValue: { [weak self] countdowns in
				guard let self = self, let countdown = countdowns.first else { return }
				// Convert milliseconds to seconds
				let endDate = Date(timeIntervalSince1970: TimeInterval(countdown.endDateTimeInUTC / 1000))
				self.targetDate = endDate
				self.startTimer()
			})
	}

	private func startTimer() {
		timerCancellable?.cancel()
		timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
			.autoconnect()
			.sink { [weak self] _ in
				self?.updateCountdown()
			}
		updateCountdown()
	}

	private func updateCountdown() {
		guard let targetDate = targetDate else { return }
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

private struct CountdownResponse: Decodable {
	let countdownId: Int
	let endDateTimeInUTC: Int64
}
