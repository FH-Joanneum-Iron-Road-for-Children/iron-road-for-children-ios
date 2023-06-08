//
//  ErrorRetryView.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 08.06.23.
//

import CoreUI
import Foundation
import SwiftUI

struct ErrorRetryView: View {
    
    var title: String = "Es ist ein Fehler aufgetreten."
    var desc: String? = nil
    var retry: () -> ()
    
    var body: some View {
        VStack {
            Text(title)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.bottom)

            
            if let desc = desc {
                Text(desc)
                    .multilineTextAlignment(.center)
                    .font(.caption)
                    .padding(.horizontal)
                    .padding(.horizontal)
            }
            
            Button("Erneut versuchen") {
                retry()
            }
            .buttonStyle(IrfcYellowRoundedButton())
            .padding(.horizontal)
            padding(.top)
        }
    }
}
