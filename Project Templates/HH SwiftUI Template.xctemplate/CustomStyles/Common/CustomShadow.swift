//___FILEHEADER___

import SwiftUI

struct CustomShadow: ViewModifier {
    var shadowRadius: CGFloat
    var shadowColor: Color
    var posX: CGFloat
    var posY: CGFloat
    
    func body(content: Content) -> some View {
        content
            .shadow(color: shadowColor, radius: shadowRadius, x: posX, y: posY)
    }
}
