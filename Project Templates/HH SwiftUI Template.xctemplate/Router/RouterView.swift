//___FILEHEADER___

import SwiftUI

/// A SwiftUI view that works in conjunction with a `RouterManager` to manage navigation paths.
public struct RouterView<V: View & Hashable>: View {
    // MARK: - ObservedObject Property
    /// The observed object responsible for managing navigation paths.
    @ObservedObject var routerManager: RouterManager<V>

    // MARK: - Initializer
    /// Initializes the `RouterView` with a `RouterManager`.
    ///
    /// - Parameter manager: The `RouterManager` managing the navigation paths.
    public init(_ manager: RouterManager<V>) {
        routerManager = manager
    }

    // MARK: - Body
    public var body: some View {
        NavigationStack(path: $routerManager.paths) {
            // Display the root view and provide navigation destination support
            routerManager.root
                .navigationDestination(for: V.self) { $0 }
        }
        // Inject the `RouterManager` as an environment object
        .environmentObject(routerManager)
    }
}
