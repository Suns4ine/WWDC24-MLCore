//
//  UIApplication+Extension.swift
//  WWDC24 MLCore
//
//  Created by Vyacheslav Pronin on 12.02.2025.
//

import SwiftUI

extension UIApplication {
	func endEditing() {
		sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}

	func isImagePlaygroundAvailable() -> Bool {
		return Bundle(identifier: "com.apple.ImagePlayground") != nil
	}

	func isWritingToolsAvailable() -> Bool {
		return Bundle(identifier: "com.apple.WritingTools") != nil
	}
}
