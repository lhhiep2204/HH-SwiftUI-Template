//___FILEHEADER___

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        return configuration
            .padding(.leading, 20)
            .frame(height: 40)
            .addBorder(cornerRadius: 20, borderColor: .gray)
    }
    
}
