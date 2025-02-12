//
//  WritingToolsView.swift
//  WWDC24 MLCore
//
//  Created by Vyacheslav Pronin on 11.02.2025.
//

import SwiftUI

extension WritingTools {

	struct View: SwiftUI.View {
		@State private var text = "Yesterday, I go to the store but it was close. We eat at a restaurant instead. The food were delicious, but the service was slow."

		var body: some SwiftUI.View {
			ZStack {
				Color.clear
					.contentShape(Rectangle())
					.onTapGesture {
						UIApplication.shared.endEditing()
					}
				VStack {
					Text("Write & Edit with Writing Tools")
						.font(.headline)
						.foregroundColor(.black)
						.padding()

					makeTextEditor()
					makeClearButton()

					Spacer()
				}
				.contentShape(Rectangle())
				.onTapGesture {
					UIApplication.shared.endEditing()
				}
			}
		}
	}
}

extension WritingTools.View {
	func makeTextEditor() -> some View {
		ZStack {
			RoundedRectangle(cornerRadius: 12)
				.fill(Color.orange)
				.frame(height: 150)

			TextEditor(text: $text)
				.scrollContentBackground(.hidden)
				.foregroundColor(.black)
				.padding(8)
		}
		.overlay(
			RoundedRectangle(cornerRadius: 12)
				.stroke(Color.black, lineWidth: 2)
		)
		.frame(height: 150)
		.padding()
		.onTapGesture {}
		.writingToolsBehavior(.complete)
	}

	func makeClearButton() -> some View {
		Button("Clear Text") {
			text = ""
		}
		.padding()
		.foregroundStyle(.white)
		.background(Color.blue)
		.cornerRadius(14)
	}
}

#Preview {
	WritingTools.View()
}
