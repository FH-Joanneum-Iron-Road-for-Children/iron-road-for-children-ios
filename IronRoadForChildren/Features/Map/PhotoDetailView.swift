// Copyright © 2023 IRFC

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
