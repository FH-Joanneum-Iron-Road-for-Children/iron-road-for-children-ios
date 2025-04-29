// Copyright © 2023 IRFC

import PDFKit
import SwiftUI

class CustomPDFView: PDFView {
	private var initialScaleFactor: CGFloat?

	override func layoutSubviews() {
		super.layoutSubviews()
		if initialScaleFactor == nil {
			initialScaleFactor = scaleFactor
			minScaleFactor = initialScaleFactor!
		}
	}
}

struct PhotoDetailView: UIViewRepresentable {
	let image: UIImage

	func makeUIView(context _: Context) -> PDFView {
		let view = CustomPDFView()
		view.document = PDFDocument()
		guard let page = PDFPage(image: image) else { return view }
		view.document?.insert(page, at: 0)
		view.autoScales = true
		return view
	}

	func updateUIView(_: PDFView, context _: Context) {}
}
