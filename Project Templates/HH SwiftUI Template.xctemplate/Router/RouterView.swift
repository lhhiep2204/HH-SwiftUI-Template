//___FILEHEADER___

import SwiftUI

struct RouterView: View {
    
    @ObservedObject var routerManager: RouterManager
    
    init(_ manager: RouterManager) {
        routerManager = manager
    }
    
    var body: some View {
        NavigationStack(path: $routerManager.paths) {
            routerManager.root
                .navigationDestination(for: Route.self) { path in
                    path
                }
        }
        .environmentObject(routerManager)
    }
    
}
