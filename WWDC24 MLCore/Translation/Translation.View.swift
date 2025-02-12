//
//  TranslationView.swift
//  WWDC24 MLCore
//
//  Created by Vyacheslav Pronin on 10.02.2025.
//

import SwiftUI
import Translation

extension Translation {

	struct View: SwiftUI.View {
		@StateObject private var service = Service()
		@State private var isPresented = false
		@State private var isLoading = false

		var body: some SwiftUI.View {
			VStack {
				Text("Translation")
					.foregroundColor(.black)
					.font(.headline)
					.padding(.vertical)

				makeSegmentedPicker()

				Text(service.text)
					.font(.title3)
					.multilineTextAlignment(.center)
					.foregroundColor(.black)
					.padding()

				HStack {
					makeOldTranslateButton()
					makeNewTranslateButton()
				}

				Spacer()
			}
		}
	}
}

extension Translation.View {

	func makeSegmentedPicker() -> some View {
		Picker("Выбор", selection: $service.selectedSegment) {
			ForEach(0..<service.languages.count, id: \.self) { index in
				Text(service.getNames(index))
			}
		}
		.pickerStyle(SegmentedPickerStyle())
		.overlay(
			RoundedRectangle(cornerRadius: 8)
				.stroke(Color.black, lineWidth: 1)
		)
		.padding()
	}

	func makeOldTranslateButton() -> some View {
		Button {
			isPresented = true
		} label: {
			Text("Old Translate")
		}
		.padding()
		.foregroundStyle(.white)
		.background(Color.blue)
		.cornerRadius(14)
		.translationPresentation(isPresented: $isPresented,
								 text: service.text)
	}

	func makeNewTranslateButton() -> some View {
		Button {
			self.service.performTranslation()
		} label: {
			if isLoading {
				ProgressView()
					.progressViewStyle(CircularProgressViewStyle(tint: .white))
			}
			Text("New Translate")
		}
		.disabled(isLoading)
		.padding()
		.foregroundStyle(.white)
		.background(Color.blue)
		.cornerRadius(14)
		.translationTask(service.configuration) { session in
			do {
				isLoading = true
				try await session.prepareTranslation()

				let response = try await session.translate(service.text)
				service.text = response.targetText
				service.lastLanguage = service.currentLanguage
			} catch let error {
				print(error)
			}

			isLoading = false
		}
	}
}

#Preview {
	Translation.View()
}
