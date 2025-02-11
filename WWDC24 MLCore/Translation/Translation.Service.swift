//
//  Translation.Service.swift
//  WWDC24 MLCore
//
//  Created by Vyacheslav Pronin on 11.02.2025.
//

import Translation

extension Translation {
	final class Service: ObservableObject {
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
}
