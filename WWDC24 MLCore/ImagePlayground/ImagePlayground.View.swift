//
//  ImagePlayground.View.swift
//  WWDC24 MLCore
//
//  Created by Vyacheslav Pronin on 11.02.2025.
//

import SwiftUI
import ImagePlayground

extension ImagePlayground {

	struct View: SwiftUI.View {
		@State private var isImagePlaygroundPresented = false
		@State private var generatedImageURL: URL?

		var body: some SwiftUI.View {
			VStack {
				Text("Image playground")
					.font(.headline)
					.foregroundColor(.black)
					.padding(.vertical)

				makeAsyncImageView()
				makeCreateImageButton()
				Spacer()
			}
		}
	}
}

extension ImagePlayground.View {

	@ViewBuilder
	func makeAsyncImageView() -> some View {
		if let imageURL = generatedImageURL {
			AsyncImage(url: imageURL) { image in
				image
					.resizable()
					.scaledToFit()
			} placeholder: {
				ProgressView()
			}
			.frame(width: 300, height: 300)
			.cornerRadius(10)
			.padding()
		} else {
			Text("Click the button below to create an image")
				.multilineTextAlignment(.center)
				.foregroundColor(.black)
				.padding()
		}
	}

	func makeCreateImageButton() -> some View {
		Button("Create Image") {
			isImagePlaygroundPresented.toggle()
		}
		.imagePlaygroundSheet(isPresented: $isImagePlaygroundPresented,
							  concept: "") { url in
			generatedImageURL = url
		} onCancellation: {
			print("User cancel create an image")
		}
		.padding()
		.foregroundStyle(.white)
		.background(Color.blue)
		.cornerRadius(14)
	}
}

#Preview {
	ImagePlayground.View()
}
