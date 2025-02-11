//
//  ContentView.swift
//  WWDC24 MLCore
//
//  Created by Vyacheslav Pronin on 10.02.2025.
//

import SwiftUI

struct ContentView: View {

	@State var selectedSegment = 0

	var sections = [Section(view: AnyView(Translation.View()),
							image: Image(systemName: "translate"),
							background: .indigo,
							colors: [.purple, .blue]),
					Section(view: AnyView(WritingTools.View()),
							image: Image(systemName: "pencil"),
							background: .red,
							colors: [.red, .orange, .yellow]),
					Section(view: AnyView(ImagePlayground.View()),
							image: Image(systemName: "photo"),
							background: .green,
							colors: [.green, .mint, .teal])]

	var body: some View {
		VStack {
			Text("WWDC24 ML Core")
				.foregroundColor(.black)
				.padding(.vertical)

			makeSegmentedPicker()
			makeSelectedSegmentView()
		}
		.background(sections[selectedSegment].background)
	}
}

extension ContentView {
	func makeSegmentedPicker() -> some View {
		Picker("Выбор", selection: $selectedSegment) {
			ForEach(0..<sections.count, id: \.self) { index in
				sections[index].image
//					.renderingMode(.template)
//					.foregroundColor(.black)
//					.colorMultiply(.black)
			}
		}
		.pickerStyle(SegmentedPickerStyle())
		.overlay(
			RoundedRectangle(cornerRadius: 8)
				.stroke(Color.black, lineWidth: 1)
		)
		.colorMultiply(.black)
		.padding([.horizontal, .bottom])
	}

	func makeSelectedSegmentView() -> some View {
		ZStack {
			RoundedRectangle(cornerRadius: 12)
				.fill(LinearGradient(
					gradient: Gradient(colors: sections[selectedSegment].colors),
					startPoint: .topLeading,
					endPoint: .bottomTrailing
				))
				.overlay(
					RoundedRectangle(cornerRadius: 12)
						.stroke(Color.black, lineWidth: 3)
				)

			sections[selectedSegment].view
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.padding()
	}
}


#Preview {
	ContentView()
}
