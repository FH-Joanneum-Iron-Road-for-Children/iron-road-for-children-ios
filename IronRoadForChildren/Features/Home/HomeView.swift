// Copyright © 2025 IRFC

import AVKit
import Combine
import SwiftUI

struct HomeView: View {
    @StateObject private var countdownViewModel = CountdownViewModel()
    @Environment(\.openURL) var openURL
    
    var body: some View {
        VStack(spacing: 4) {
            VideoPlayerView(
                videoURL: URL(
                    string:
                        "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4"
                )!)
            
            countdownView
            
            // Main Banner Image with social media icons
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
                                string: "https://facebook.com/irfcat")!
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
                                string: "https://instagram.com/irfcat")!
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
    
    private var countdownView: some View {
        ZStack {
            Color(red: 0.9, green: 0.3, blue: 0.3)
            
            ZStack {
                if let image = UIImage(named: "countdownShine") {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .scaleEffect(1.2)
                        .frame(height: 120)
                        .clipped()
                        .opacity(0.1)
                }
                
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        CountdownItem(
                            value: countdownViewModel.days, label: "DAYS"
                        )
                        CountdownItem(
                            value: countdownViewModel.hours, label: "HOURS"
                        )
                        CountdownItem(
                            value: countdownViewModel.minutes, label: "MIN."
                        )
                        CountdownItem(
                            value: countdownViewModel.seconds, label: "SEC."
                        )
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 24)
                    .overlay(
                        Rectangle()
                            .frame(height: 3)
                            .foregroundColor(.white)
                            .padding(.horizontal, 40)
                            .offset(y: 14),
                        alignment: .center
                    )
                }
            }
        }
    }
    
    private var mainBannerView: some View {
        Button(action: {
            openURL(URL(string: "https://irfc.at")!)
        }) {
            if let image = UIImage(named: "irfcHome") {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
        }
    }
    
    struct CountdownItem: View {
        var value: Int
        var label: String
        
        var body: some View {
            VStack(spacing: 8) {
                Text("\(value)")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .foregroundColor(.yellow)
                    .minimumScaleFactor(0.5)
                
                Text(label)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.yellow)
                    .minimumScaleFactor(0.7)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
	HomeView()
}
