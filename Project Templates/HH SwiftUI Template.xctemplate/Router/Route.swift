//___FILEHEADER___

import SwiftUI

enum Route {
    case launchScreen
    case login
    case home
    case detail(topic: String)
}

extension Route: View, Hashable {
    var body: some View {
        switch self {
        case .launchScreen:
            LaunchScreenView()
        case .login:
            LoginView()
        case .home:
            HomeView()
        case .detail(let topic):
            DetailView(topic: topic)
        }
    }
}
