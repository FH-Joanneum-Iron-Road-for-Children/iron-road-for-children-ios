//
//  ExampleView.swift
//
//
//  Created by Alexander Kauer on 12.03.23.
//

import CoreUI
import SwiftUI

public struct ExampleView: View {
    public let text = "Hello, World!"

    @StateObject var viewModel = ExampleViewModel()

    // needed to perform animation
    @State var isLoading = true

    public init() {}

    public var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                Button("Konzert") {}
                    .buttonStyle(IrfcYellowRoundedButton())

                Button("Konzert") {}
                    .buttonStyle(IrfcWhiteRoundedButton())
            }

            if isLoading {
                ProgressView().padding()
            } else if let text = viewModel.model?.url {
                Text(text)
                    .font(.caption)
            }

            if let errorText = viewModel.errorText {
                Text(errorText)
                    .font(.callout)
                    .foregroundColor(.red)
            }

            Button("Retry", action: {
                Task {
                    await viewModel.loadTextFromServer()
                }
            })
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .onReceive(viewModel.$isLoading) { isLoading in
            withAnimation {
                self.isLoading = isLoading
            }
        }
        .onAppear {
            Task {
                await viewModel.loadTextFromServer()
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}
