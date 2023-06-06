//
//  PhotoDetailView.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 06.06.23.
//

import PDFKit
import SwiftUI

struct PhotoDetailView: UIViewRepresentable {
	let image: UIImage

	func makeUIView(context _: Context) -> PDFView {
		let view = PDFView()
		view.document = PDFDocument()
		guard let page = PDFPage(image: image) else { return view }
		view.document?.insert(page, at: 0)
		view.autoScales = true
		return view
	}

	func updateUIView(_: PDFView, context _: Context) {
		// empty
	}
}
