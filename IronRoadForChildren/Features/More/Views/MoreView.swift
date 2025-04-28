import SwiftUI

struct MoreView: View {
    @Environment(\.openURL) var openURL
    
    // IRFC Farben
    private let irfcRed = Color(red: 239/255, green: 83/255, blue: 80/255)
    private let irfcYellow = Color(red: 255/255, green: 215/255, blue: 0/255)
    private let irfcDarkBlue = Color(red: 30/255, green: 40/255, blue: 70/255)
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Weißer Bereich mit Text
                VStack(alignment: .leading, spacing: 0) {
                    // Text-Inhalte - nur der zweite Absatz wird angezeigt, wie im Screenshot
                    Text("Der Eintritt für das komplette Event-Weekend ist für Besucher kostenlos, stattdessen werden unter dem Motto \"Ein Herz für Kinder - Benzin im Blut\", Spendengelder für erkrankte Kinder aus ganz Österreich gesammelt.")
                        .font(.system(size: 17))
                        .lineSpacing(4)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 24)
                }
                .background(Color.white)
                
                // Roter Container mit allen anderen Elementen
                VStack(spacing: 0) {
                    // ROCK. RIDE. DONATE! Banner
                    Text("ROCK. RIDE. DONATE!")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal, 20)
                        .padding(.top, 80)
                        .padding(.bottom, 60)
                    
                    // Spenden-Button
                    Button(action: {
                        openURL(URL(string: "https://irfc.at/home/charity/")!)
                    }) {
                        HStack {
                            Image(systemName: "heart.fill")
                                .font(.title3)
                            
                            Text("Spenden")
                                .font(.system(size: 22, weight: .bold))
                            
                            Image(systemName: "heart.fill")
                                .font(.title3)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(irfcYellow)
                        .foregroundColor(.black)
                        .cornerRadius(30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.white, lineWidth: 3)
                        )
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
                    
                    // Zum Gewinnspiel-Button
                    NavigationLink(destination: EmptyView()) {
                        HStack {
                            Image(systemName: "gift.fill")
                                .foregroundColor(.black)
                            
                            Text("Zum Gewinnspiel")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 16)
                    
                    // Zur Galerie-Button
                    NavigationLink(destination: GalleryView()) {
                        HStack {
                            Image(systemName: "photo.on.rectangle.angled")
                                .foregroundColor(.black)
                            
                            Text("Zur Galerie")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    }
                    
                    // Abstand zwischen Galerie und Impressum
                    Spacer()
                        .frame(height: 60)
                    
                    // Info-Links (Impressum, Datenschutz, etc.)
                    VStack(spacing: 0) {
                        // Impressum
                        Link(destination: URL(string: "https://irfc.at/kontakt/impressum/")!) {
                            HStack {
                                Image(systemName: "info.circle")
                                    .foregroundColor(.white)
                                
                                Text("Impressum")
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical, 14)
                            .padding(.horizontal, 20)
                        }
                        
                        Divider()
                            .background(Color.white.opacity(0.3))
                        
                        // Datenschutz
                        Link(destination: URL(string: "https://irfc.at/kontakt/datenschutz/")!) {
                            HStack {
                                Image(systemName: "shield")
                                    .foregroundColor(.white)
                                
                                Text("Datenschutz")
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical, 14)
                            .padding(.horizontal, 20)
                        }
                        
                        Divider()
                            .background(Color.white.opacity(0.3))
                        
                        // Acknowledgements (auskommentiert, da nicht im Screenshot zu sehen)
                        
                        NavigationLink(destination: EmptyView()) {
                            HStack {
                                Image(systemName: "hands.clap")
                                    .foregroundColor(.white)
                                
                                Text("Acknowledgements")
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical, 14)
                            .padding(.horizontal, 20)
                        }
                    }
                    
                    // Füllraum zum Tabbar
                    Spacer()
                        .frame(height: 100)
                }
                .frame(maxWidth: .infinity)
                .background(irfcRed)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.white)
        .navigationBarTitleDisplayMode(.inline)
        .overlay(
            VStack {
                Spacer()
                TabBarView()
            }
            .edgesIgnoringSafeArea(.bottom),
            alignment: .bottom
        )
    }
}

// Tab-Bar View
struct TabBarView: View {
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            VStack {
                Image(systemName: "house.fill")
                    .font(.system(size: 22))
                Text("Home")
                    .font(.caption)
            }
            .foregroundColor(Color(red: 150/255, green: 170/255, blue: 200/255))
            Spacer()
            
            VStack {
                Image(systemName: "calendar")
                    .font(.system(size: 22))
                Text("Program")
                    .font(.caption)
            }
            .foregroundColor(Color(red: 150/255, green: 170/255, blue: 200/255))
            Spacer()
            
            VStack {
                Image(systemName: "hand.thumbsup")
                    .font(.system(size: 22))
                Text("Voting")
                    .font(.caption)
            }
            .foregroundColor(Color(red: 150/255, green: 170/255, blue: 200/255))
            Spacer()
            
            VStack {
                Image(systemName: "map")
                    .font(.system(size: 22))
                Text("Karte")
                    .font(.caption)
            }
            .foregroundColor(Color(red: 150/255, green: 170/255, blue: 200/255))
            Spacer()
            
            VStack {
                Image(systemName: "ellipsis")
                    .font(.system(size: 22))
                Text("Mehr")
                    .font(.caption)
            }
            .foregroundColor(.yellow)
            Spacer()
        }
        .padding(.top, 8)
        .padding(.bottom, 30)
        .background(Color(red: 30/255, green: 40/255, blue: 70/255))
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MoreView()
        }
    }
}
