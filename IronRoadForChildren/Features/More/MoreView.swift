// Copyright © 2023 IRFC

import CoreUI
import SwiftUI

struct MoreView: View {
	@Environment(\.openURL) var openURL
	@State private var showPlaylist = false

	var body: some View {
		List {
			Section(header: Text("Über uns")) {
				Text(text)
			}

			Section {
				VStack(spacing: 20) {
					Image("LIDLogo")
						.resizable()
						.scaledToFit()
						.frame(height: 50)
						.accessibilityLabel("LID Logo")

					Image("SHSLogo")
						.resizable()
						.scaledToFit()
						.frame(height: 50)
						.accessibilityLabel("SHS Logo")
				}
				.frame(maxWidth: .infinity)
				.padding(.vertical, 8)

				HStack {
					Spacer()

					Button(action: {
						openURL(URL(string: "https://irfc.at/#spenden")!)
					}) {
						HStack {
							Image("donate")
								.imageScale(.medium)
							Text("Spenden")
						}
					}
					.buttonStyle(IrfcYellowRoundedButton())

					Spacer()
				}

				HStack {
					Spacer()

					Text(donateText)
						.font(.footnote)
						.foregroundColor(.secondary)
						.multilineTextAlignment(.center)

					Spacer()
				}

				HStack {
					Spacer()

					Button(action: {
						openURL(URL(string: "https://www.oebb.at/de/regionale-angebote/steiermark/freizeit-ticket-steiermark")!)
					}) {
						HStack {
							Image(systemName: "lightbulb")
								.imageScale(.medium)
							Text("IRFC Tipp")
						}
					}
					.buttonStyle(IrfcWhiteRoundedButton())

					Spacer()
				}
			}
			.listRowBackground(Color.clear)
			.listRowSeparator(.hidden)

			Section {
				Link(destination: galleryURL) {
					Label("Galerie", systemImage: "photo.on.rectangle.angled")
				}

				NavigationLink {
					PlaylistView()
				} label: {
					Label("Playlist", systemImage: "music.note.list")
				}

				Link(destination: donateChildrenURL) {
					Label("Spendenkinder", systemImage: "heart.circle")
				}

				Link(destination: onlineShopURL) {
					Label("Online-Shop", systemImage: "cart")
				}

				Link(destination: raffleURL) {
					Label("Verlosung", systemImage: "ticket")
				}

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
	private let donateChildrenURL = URL(string: "https://irfc.at/home/spendenkinderprojekte/")!
	private let onlineShopURL = URL(string: "https://irfc.at/shop/")!
	private let raffleURL = URL(string: "https://irfc.at/am-event/#verlosung")!
	private let galleryURL = URL(string: "https://irfc.at/home/fotos/")!

	private let text = """
	Die Iron Road for Children, kurz IRFC, ist Österreichs größtes markenoffenes Festival-Weekend \
	für Bikes, Vespas und US-Cars. Der Eintritt für das komplette Event-Weekend ist für Besucher \
	kostenlos, stattdessen werden unter dem Motto "Ein Herz für Kinder - Benzin im Blut", \
	Spendengelder für erkrankte Kinder aus ganz Österreich gesammelt. Neben Ausfahrten mit den \
	Fahrzeugen, zahlreichen Live Konzerten, einem Kinderbereich und einer Tattoo-Area wird den \
	Besuchern auch eine große Aussteller- und Streetfood-Area geboten. In diesem Jahr wird das \
	Programm auch um eine Custom Bike Area erweitert und die IRFC ist Host der \
	"Internationalen Österreichischen Custom Bike Staatsmeisterschaft". Die IRFC ist ein Event für \
	die ganze Familie und zählt mittlerweile über 40.000 Besucher.
	"""

	private let creatorText = """
	Zur Verfügung gestellt vom FH JOANNEUM Studiengang Mobile Software Development.
	"""

	private let donateText = """
	Alle IRFC-Spenden werden notariell geprüft und ohne Abzüge an die Spendenvereine \
	weitergeleitet. Dank unserer Sponsor-Partnern bleibt der Eintritt für unsere Besucher \
	kostenlos. Bitte unterstützt unsere IRFC-Spendenkinder!
	"""
}

struct MoreView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			MoreView()
		}
	}
}
