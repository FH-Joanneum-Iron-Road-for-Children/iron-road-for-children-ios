//
//  EventMapView.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 24.03.23.
//

import SwiftUI

struct EventMapView: View {
	@State private var zoomScale: CGFloat = 1
	@State private var previousZoomScale: CGFloat = 1
	private let minZoomScale: CGFloat = 1
	private let maxZoomScale: CGFloat = 5

	var zoomGesture: some Gesture {
		MagnificationGesture()
			.onChanged(onZoomGestureStarted)
			.onEnded(onZoomGestureEnded)
	}

	var body: some View {
		GeometryReader { proxy in
			ScrollView([.vertical, .horizontal]) {
				Image("irfcMap")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: proxy.size.width * max(minZoomScale, zoomScale))
					.frame(maxHeight: .infinity)
			}
			.onTapGesture(count: 2, perform: onImageDoubleTapped)
			.gesture(zoomGesture)
		}
	}

	func onZoomGestureStarted(value: MagnificationGesture.Value) {
		withAnimation(.easeIn(duration: 0.1)) {
			let delta = value / previousZoomScale
			previousZoomScale = value
			let zoomDelta = zoomScale * delta
			var minMaxScale = max(minZoomScale, zoomDelta)
			minMaxScale = min(maxZoomScale, minMaxScale)
			zoomScale = minMaxScale
		}
	}

	func onZoomGestureEnded(value _: MagnificationGesture.Value) {
		previousZoomScale = 1
		if zoomScale <= 1 {
			resetImageState()
		} else if zoomScale > 5 {
			zoomScale = 5
		}
	}

	func resetImageState() {
		withAnimation(.interactiveSpring()) {
			zoomScale = 1
		}
	}

	func onImageDoubleTapped() {
		if zoomScale == 1 {
			withAnimation(.spring()) {
				zoomScale = 5
			}
		} else {
			resetImageState()
		}
	}
}

struct EventMapView_Previews: PreviewProvider {
	static var previews: some View {
		EventMapView()
	}
}
