//___FILEHEADER___

import SwiftUI

struct CustomBorder: ViewModifier {
    var cornerRadius: CGFloat
    var borderColor: Color
    var lineWidth: CGFloat
    
    func body(content: Content) -> some View {
        content
            .cornerRadius(cornerRadius)
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: lineWidth)
            }
    }
}
