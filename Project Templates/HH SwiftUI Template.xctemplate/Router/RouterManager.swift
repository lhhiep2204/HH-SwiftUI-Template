//___FILEHEADER___

import Combine

final class RouterManager: ObservableObject {
    
    @Published var root: Route
    @Published var paths = [Route]()
    
    init(root rootView: Route) {
        root = rootView
    }
    
    func push(_ path: Route) {
        paths.append(path)
    }
    
    func pop() {
        paths.removeLast()
    }
    
    func popToRoot() {
        paths.removeAll()
    }
    
    func updateRoot(_ rootView: Route) {
        root = rootView
        paths.removeAll()
    }
    
}
