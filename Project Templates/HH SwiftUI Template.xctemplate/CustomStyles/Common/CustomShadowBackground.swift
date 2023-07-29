//___FILEHEADER___

import SwiftUI

struct CustomShadowBackground: ViewModifier {
    
    enum Style {
        case drop, inner
    }
    
    var type: Style
    var backgroundColor: Color
    var radius: CGFloat
    var posX: CGFloat
    var posY: CGFloat
    
    func body(content: Content) -> some View {
        switch type {
        case .drop:
            content
                .background(in: RoundedRectangle(cornerRadius: radius))
                .backgroundStyle(backgroundColor.shadow(.drop(radius: radius,
                                                                   x: posX,
                                                                   y: posY)))
        case .inner:
            content
                .background(in: RoundedRectangle(cornerRadius: radius))
                .backgroundStyle(backgroundColor.shadow(.inner(radius: radius,
                                                                   x: posX,
                                                                   y: posY)))
        }
    }
    
}
