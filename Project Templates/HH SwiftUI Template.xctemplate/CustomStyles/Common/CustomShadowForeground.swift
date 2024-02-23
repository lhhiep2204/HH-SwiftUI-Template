//___FILEHEADER___

import SwiftUI

struct CustomShadowForeground: ViewModifier {
    enum Style {
        case drop, inner
    }
    
    var type: Style
    var foregroundColor: Color
    var radius: CGFloat
    var posX: CGFloat
    var posY: CGFloat
    
    func body(content: Content) -> some View {
        switch type {
        case .drop:
            content
                .foregroundStyle(foregroundColor.shadow(.drop(radius: radius,
                                                                   x: posX,
                                                                   y: posY)))
        case .inner:
            content
                .foregroundStyle(foregroundColor.shadow(.inner(radius: radius,
                                                                   x: posX,
                                                                   y: posY)))
        }
    }
}
