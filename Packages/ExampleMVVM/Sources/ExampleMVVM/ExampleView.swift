//
//  ExampleView.swift
//  
//
//  Created by Alexander Kauer on 12.03.23.
//

import SwiftUI

public struct ExampleView: View {
    
    let text = "Hello, World!"
    
    @StateObject var viewModel = ExampleViewModel()
    
    // needed to perform animation 
    @State var isLoading = true
    
    public init() { }
    
    public var body: some View {
        VStack {
            Text(text)
                .font(.headline)
                .padding()
            
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
    
