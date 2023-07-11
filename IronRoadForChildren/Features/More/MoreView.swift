// Copyright © 2023 IRFC

import CoreUI
import SwiftUI

struct MoreView: View {
	@Environment(\.openURL) var openURL

	var body: some View {
		List {
			Section(header: Text("Über uns")) {
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
				Link(destination: impressumURL) {
					Label("Impressum", systemImage: "info.circle")
				}

				Link(destination: dataPrivacyURL) {
					Label("Datenschutz", systemImage: "shield")
				}

				NavigationLink {
					AcknowView()
				} label: {
					Label("Acknowledgements", systemImage: "hands.clap")
				}
			}

			Section {
				VStack {
					HStack {
						Spacer()
//
						Text(creatorText)
							.font(.caption)
							.multilineTextAlignment(.center)

						Spacer()
					}

					Text("Version: \(Bundle.main.appVersionLong) (\(Bundle.main.appBuild))")
						.padding()
						.font(.caption2)
				}
			}
			.listRowBackground(Color.clear)
		}
	}

	private let impressumURL = URL(string: "https://irfc.at/kontakt/impressum/")!
	private let dataPrivacyURL = URL(string: "https://irfc.at/kontakt/datenschutz/")!

	private let text = """
	Die Iron Road for Children, kurz IRFC, ist Österreichs größtes markenoffenes Festival-Weekend für Bikes, Vespas und US-Cars.
	Der Eintritt für das komplette Event-Weekend ist für Besucher kostenlos, stattdessen werden unter dem Motto \"Ein Herz für Kinder - Benzin im Blut\", Spendengelder für erkrankte Kinder aus ganz Österreich gesammelt.
	Neben Ausfahrten mit den Fahrzeugen, zahlreichen Live Konzerten, einem Kinderbereich und einer Tattoo-Area wird den Besuchern auch eine große Austeller- und Streetfood-Area geboten.
	In diesem Jahr wird das Programm auch um eine Custom Bike Area erweitert und die IRFC ist Host der \"Internationalen Österreichischen Custom Bike Staatsmeisterschaft\".
	Die IRFC ist ein Event für die ganze Familie und zählt mittlerweile über 40.000 Besucher.
	"""

	private let creatorText = """
	Zur Verfügung gestellt vom FH JOANNEUM
	 Studiengang Mobile Software Development.
	"""
}

struct MoreView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			MoreView()
		}
	}
}
