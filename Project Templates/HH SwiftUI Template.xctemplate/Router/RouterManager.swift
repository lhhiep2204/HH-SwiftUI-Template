//___FILEHEADER___

import Combine
import SwiftUI

/// A class responsible for managing navigation paths in a SwiftUI application.
public final class RouterManager<V: View & Hashable>: ObservableObject {
    // MARK: - Published Properties
    /// The root view of the navigation hierarchy.
    @Published var root: V
    /// The stack of navigation paths.
    @Published var paths = [V]()

    // MARK: - Initializer
    /// Initializes the `RouterManager` with a root view.
    ///
    /// - Parameter rootView: The root view of the navigation hierarchy.
    public init(root rootView: V) {
        root = rootView
    }
}

public extension RouterManager {
    /// Pushes a new view onto the navigation stack.
    ///
    /// - Parameter path: The view to be pushed onto the stack.
    func push(_ path: V) {
        paths.append(path)
    }

    /// Pops the top view from the navigation stack.
    func pop() {
        paths.removeLast()
    }

    /// Pops all views from the navigation stack, leaving only the root view.
    func popToRoot() {
        paths.removeAll()
    }

    /// Updates the root view of the navigation hierarchy.
    ///
    /// - Parameter rootView: The new root view.
    func updateRoot(_ rootView: V) {
        root = rootView
        paths.removeAll()
    }

    /// The current root view in the navigation hierarchy.
    var currentRoot: V {
        root
    }
}
