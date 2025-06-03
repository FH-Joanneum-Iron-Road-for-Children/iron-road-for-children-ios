// Copyright © 2025 IRFC
import Foundation
import SwiftUI
import Combine

// Define the correct data model for your API response
struct SocialMedia: Codable {
    let socialMediaId: Int
    let title: String
    let link: String
}

struct SocialMediaView: View {
    @State private var instagramLink: String?
    @State private var facebookLink: String?
    @State private var fetchCancellable: AnyCancellable?
    @Environment(\.openURL) var openURL
    
    init() {
        fetchSocialMediaLinks()
    }
    
    private func fetchSocialMediaLinks() {
        let url = world.serverUrlWith(path: "/api/socialMedias")
        
        fetchCancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [SocialMedia].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching social media links: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { socialMedias in
                // Extract Instagram and Facebook links
                for socialMedia in socialMedias {
                    switch socialMedia.title.lowercased() {
                    case "instagram":
                        self.instagramLink = socialMedia.link
                    case "facebook":
                        self.facebookLink = socialMedia.link
                    default:
                        break
                    }
                }
            })
    }
    
    var body: some View {
        ZStack {
            Image("irfcHome")
                .resizable()
                .aspectRatio(contentMode: .fill)

            // Social media icons overlaid on the banner
            VStack {
                Spacer()

                HStack {
                    Link(
                        destination: URL(
                            string: facebookLink ?? "https://www.facebook.com/irfc_festival/")!
                    ) {
                        Image("facebook")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
                    .padding(.leading, 15)

                    Spacer()

                    Link(
                        destination: URL(
                            string: instagramLink ?? "https://www.instagram.com/irfc_festival/")!
                    ) {
                        Image("insta")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .background(Color.clear)
                            .cornerRadius(5)
                    }
                    .padding(.trailing, 15)
                }
                .padding(.bottom, 65)
            }
        }
        .onTapGesture {
            openURL(URL(string: "https://irfc.at")!)
        }
    }
}
