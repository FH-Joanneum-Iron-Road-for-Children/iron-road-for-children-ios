//
//  MoreView.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 24.03.23.
//

import CoreUI
import SwiftUI

struct MoreView: View {
	let text = """
	Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
	At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
	"""

	@Environment(\.openURL) var openURL

	var body: some View {
		List {
			Section {
				Text(text)
			}

			Section {
				HStack {
					Spacer()

					Button(action: {
						openURL(URL(string: "https://irfc.at/home/charity/")!)
					}) {
						HStack {
							Image("donate")
							Text("Spenden")
						}
					}
					.buttonStyle(IrfcYellowRoundedButton())

					Spacer()
				}
			}
			.listRowBackground(Color.clear)

			Section {
				NavigationLink(destination: ImpressumView(), label: {
					HStack {
						Image(systemName: "info.circle")
						Text("Impressum")
						Spacer()
					}
				})

				NavigationLink(destination: DataPrivacyView(), label: {
					HStack {
						Image(systemName: "shield")
						Text("Datenschutz")
						Spacer()
					}
				})
			}

			Section {
				HStack {
					Spacer()

					Text("""
					     Zur Verfügung gestellt vom FH JOANNEUM
					     Studiengang Mobile Software Development.
					""")
					.font(.caption)
					.multilineTextAlignment(.center)
					.padding()

					Spacer()
				}
			}
			.listRowBackground(Color.clear)
		}
	}
}

struct MoreView_Previews: PreviewProvider {
	static var previews: some View {
		MoreView()

		MoreView()
			.preferredColorScheme(.dark)
	}
}
