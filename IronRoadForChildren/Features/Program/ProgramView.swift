//
//  ProgramView.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 15.03.23.
//

import CoreUI
import SwiftUI

struct ProgramView: View {
	@StateObject var viewModel = ProgramViewModel()
	@State var selectedTab: Int = 0

	var body: some View {
		VStack {
			if let errorDesc = viewModel.error {
                ErrorRetryView(
                    title: "Es ist ein Fehler aufgetreten.",
                    desc: errorDesc,
                    retry: {
                        viewModel.loadEvents()
                        viewModel.loadCategories()
                    }
                )
        } else {
                VStack(spacing: 0) {
                    if !dayEvents.isEmpty {
                        ProgramTabBarHeader(
                            currentTab: $selectedTab,
                            tabBarOptions: dayEvents.map { $0.name }
                        )
                    }
                    
                    if viewModel.isLoadingCategories {
                        ProgressView()
                            .padding()
                    } else {
                        FiltersRowView()
                            .environmentObject(viewModel)
                    }
                    
                    if viewModel.isLoadingEvents {
                        Spacer()
                        ProgressView()
                        Spacer()
                    } else {
                        TabView(selection: $selectedTab) {
                            ForEach(Array(dayEvents.enumerated()), id: \.offset) { index, day in
                                DayView(events: day.events)
                                    .tag(index)
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .animation(.easeInOut(duration: 0.3), value: selectedTab)
                    }
                }
			}
		}
	}
}

struct ProgramView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ProgramView()
				.navigationTitle("Program")
				.navigationBarTitleDisplayMode(.inline)
		}
	}
}
