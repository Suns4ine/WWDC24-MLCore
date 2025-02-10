//
//  TranslationView.swift
//  WWDC24 MLCore
//
//  Created by Vyacheslav Pronin on 10.02.2025.
//

//import SwiftUI
//import Translation
//
//struct TranslationView: View {
//	let textToTranslate: String
//	@State private var translatedText: String?
//
//	var body: some View {
//		VStack {
//			Text(textToTranslate)
//			if let translatedText = translatedText {
//				Text(translatedText)
//					.foregroundColor(.gray)
//			}
//		}
//		.task {
//			await translateText()
//		}
//	}
//
//	func translateText() async {
//		do {
//			let session = TranslationSession.Configuration(
//				source: nil,
//				target: Locale.Language(languageCode: .italian)
//			)
//			
//			try await session.prepareTranslation()
//
//			let response = try await session.translate(text)
//			self.text = response.targetText
//
//
//			let request = TranslationRequest(sourceText: textToTranslate)
//			let response = try await session.translate(request)
//			translatedText = response.translatedText
//		} catch {
//			print("Ошибка перевода: \(error)")
//		}
//	}
//}
