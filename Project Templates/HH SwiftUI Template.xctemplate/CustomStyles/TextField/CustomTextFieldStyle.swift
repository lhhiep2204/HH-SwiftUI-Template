//___FILEHEADER___

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        return configuration
            .padding(.leading, 20)
            .frame(height: 40)
            .border(radius: 20, color: .gray)
    }
}
