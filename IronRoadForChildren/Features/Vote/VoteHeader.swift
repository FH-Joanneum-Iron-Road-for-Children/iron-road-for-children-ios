//
//  VoteHeader.swift
//  IronRoadForChildren
//
//  Created by Daniel Zellner on 25.04.23.
//

import SwiftUI

struct VoteHeader: View {
	var textHeader = """
	Hier hast du die Möglichkeit für deine Lieblingsband einmalig abzustimmen.
	Die Band mit den meisten Stimmen bekommt die Möglichkeit bei NovaRock aufzutreten.
	"""

	var body: some View {
		Text(textHeader)
			.padding()
	}
}

struct VoteHeader_Previews: PreviewProvider {
	static var previews: some View {
		VoteHeader()
	}
}
