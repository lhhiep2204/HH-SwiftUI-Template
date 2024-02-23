//___FILEHEADER___

import SwiftUI

public extension Color {
    init(hex: String, opacity: Double = 1) {
        let hexCode = hex.trim.replace("#", with: "")

        guard hexCode.count == 6, let rgb = UInt64(hexCode, radix: 16) else {
            fatalError("Invalid hex color code: \(hex)")
        }

        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue, opacity: opacity)
    }

    init(red: Int, green: Int, blue: Int, opacity: Double = 1) {
        let red = Double(red) / 255.0
        let green = Double(green) / 255.0
        let blue = Double(blue) / 255.0

        self.init(red: red, green: green, blue: blue, opacity: opacity)
    }
}
