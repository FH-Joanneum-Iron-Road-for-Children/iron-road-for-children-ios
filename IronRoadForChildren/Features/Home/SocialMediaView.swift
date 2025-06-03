// Copyright © 2025 IRFC
import Foundation
import SwiftUI
import Combine

// Define correct data model for API response
struct SocialMedia: Codable {
    let socialMediaId: Int
    let title: String
    let link: String
}

struct SocialMediaView: View {
    @State private var instagramLink: String?
    @State private var facebookLink: String?
    @State private var fetchCancellable: AnyCancellable?
    @State private var isLoading = false
    @Environment(\.openURL) var openURL
    
    private func fetchSocialMediaLinks() {
        guard !isLoading else {
            return
        }
        
        isLoading = true
        let url = world.serverUrlWith(path: "/api/socialMedias")
        
        fetchCancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [SocialMedia].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    print("❌ SocialMediaView: Error fetching social media links from backend: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { socialMedias in
                // Extract Instagram and Facebook links
                for socialMedia in socialMedias {
                    switch socialMedia.title.lowercased() {
                    case "instagram":
                        self.instagramLink = socialMedia.link
                        print("✅ SocialMediaView: Using Instagram link from backend: \(socialMedia.link)")
                    case "facebook":
                        self.facebookLink = socialMedia.link
                        print("✅ SocialMediaView: Using Facebook link from backend: \(socialMedia.link)")
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
        .onAppear {
            // Only fetch if we don't already have the data and we're not already loading
            if (instagramLink == nil || facebookLink == nil) && !isLoading {
                fetchSocialMediaLinks()
            }
        }
    }
}
