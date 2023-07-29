//___FILEHEADER___

import Foundation

public enum Regex: String {
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}",
         letter = "^(?=.*[a-zA-Z])",
         number = "^(?=.*[0-9])",
         specialCharacter = "^(?=.*[$@$!%*#?&])",
         alphaNumeric = "^[a-zA-Z0-9]+$"
}
