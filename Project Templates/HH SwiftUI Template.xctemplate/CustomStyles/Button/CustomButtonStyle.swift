//___FILEHEADER___

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) var isEnabled
    @Environment(\.colorScheme) var colorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background((configuration.isPressed || !isEnabled) ? .gray : colorScheme == .dark ? .white : .black)
            .foregroundColor(colorScheme == .dark ? .black : .white)
            .frame(height: 40)
            .clipShape(Capsule())
    }
    
}
