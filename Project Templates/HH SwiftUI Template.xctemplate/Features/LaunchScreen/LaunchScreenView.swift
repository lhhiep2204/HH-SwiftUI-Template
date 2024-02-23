//___FILEHEADER___

import SwiftUI

struct LaunchScreenView: View {
    // MARK: - Properties
    @EnvironmentObject private var router: RouterManager<Route>
    @AppStorage(UserDefaultKey.isLogin) private var isLoggedIn: Bool = false
    
    var body: some View {
        Text("HH SwiftUI Template")
            .font(.bold(.title)())
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    router.updateRoot(isLoggedIn ? .home : .login)
                }
            }
    }
}

#Preview {
    LaunchScreenView()
}
