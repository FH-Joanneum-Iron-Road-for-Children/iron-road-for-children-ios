//
//  String+Extensions.swift
//  IronRoadForChildren
//
//  Created by Alexander Kauer on 10.07.23.
//

import Foundation

extension String {
	var attributedMarkdownString: AttributedString? {
		return try? AttributedString(markdown: self)
	}
}
