//___FILEHEADER___

import SwiftUI

extension View {
    
    func addBorder(cornerRadius: CGFloat = 8,
                   borderColor: Color = .clear,
                   lineWidth: CGFloat = 1) -> some View {
        modifier(CustomBorder(cornerRadius: cornerRadius,
                                   borderColor: borderColor,
                                   lineWidth: lineWidth))
    }
    
    func addShadow(radius: CGFloat = 8,
                   color: Color = .gray,
                   posX: CGFloat = 3,
                   posY: CGFloat = 3) -> some View {
        modifier(CustomShadow(shadowRadius: radius,
                                   shadowColor: color,
                                   posX: posX,
                                   posY: posY))
    }
    
    func dropShadowBackground(backgroundColor: Color = .white,
                              radius: CGFloat = 8,
                              posX: CGFloat = 3,
                              posY: CGFloat = 3) -> some View {
        modifier(CustomShadowBackground(type: .drop,
                                             backgroundColor: backgroundColor,
                                             radius: radius,
                                             posX: posX,
                                             posY: posY))
    }
    
    func innerShadowBackground(backgroundColor: Color = .white,
                               radius: CGFloat = 8,
                               posX: CGFloat = 3,
                               posY: CGFloat = 3) -> some View {
        modifier(CustomShadowBackground(type: .inner,
                                             backgroundColor: backgroundColor,
                                             radius: radius,
                                             posX: posX,
                                             posY: posY))
    }
    
    func dropShadowForeground(foregroundColor: Color = .white,
                              radius: CGFloat = 8,
                              posX: CGFloat = 3,
                              posY: CGFloat = 3) -> some View {
        modifier(CustomShadowForeground(type: .drop,
                                             foregroundColor: foregroundColor,
                                             radius: radius,
                                             posX: posX,
                                             posY: posY))
    }
    
    func innerShadowForeground(foregroundColor: Color = .white,
                               radius: CGFloat = 8,
                               posX: CGFloat = 3,
                               posY: CGFloat = 3) -> some View {
        modifier(CustomShadowForeground(type: .inner,
                                             foregroundColor: foregroundColor,
                                             radius: radius,
                                             posX: posX,
                                             posY: posY))
    }
    
}
