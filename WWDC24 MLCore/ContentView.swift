//
//  ContentView.swift
//  WWDC24 MLCore
//
//  Created by Vyacheslav Pronin on 10.02.2025.
//

import SwiftUI
import Translation

struct ContentView: View {

	@StateObject var translationService = TranslationService()

	var body: some View {
		NavigationStack {
			makeTranslationView()
		}
	}

	private func makeTranslationView() -> some View {
		VStack {
			Text("Translation")
				.padding(.vertical)
			Picker("Выбор", selection: $translationService.selectedSegment) {
				ForEach(0..<translationService.languages.count, id: \.self) { index in
					Text(translationService.getNames(index))
				}
			}
			.pickerStyle(SegmentedPickerStyle())
			.padding(.horizontal)
			.padding(.bottom)

			Text(translationService.text)
				.font(.title3)
				.multilineTextAlignment(.center)
			Spacer()
		}

		.toolbar {
			Button {
				self.translationService.performTranslation()
			} label: {
				Image(systemName: "translate")
			}
		}

		.translationTask(translationService.configuration) { session in
			do {
				try await session.prepareTranslation()

				let response = try await session.translate(translationService.text)
				translationService.text = response.targetText
				translationService.lastLanguage = translationService.currentLanguage
			} catch let error {
				print(error)
			}
		}
	}
}

#Preview {
    ContentView()
}

final class TranslationService: ObservableObject {
	@Published var text = "Where's the money, Lebowski?"
	@Published var configuration: TranslationSession.Configuration?
	@Published var lastLanguage: Locale.LanguageCode = .english

	var selectedSegment = 0
	var currentLanguage: Locale.LanguageCode {
		languages[selectedSegment]
	}

	let languages: [Locale.LanguageCode] = [.russian, .english, .french]
	let langugeNames: [Locale.LanguageCode: String] =
	[
		.russian: "Russian",
		.english: "English",
		.french: "French"
	]

	func getNames(_ index: Int) -> String {
		langugeNames[languages[index]] ?? "Unknow"
	}

	func performTranslation() {
		configuration = TranslationSession.Configuration(
			source: Locale.Language(languageCode: lastLanguage),
			target: Locale.Language(languageCode: currentLanguage)
		)
	}
}
