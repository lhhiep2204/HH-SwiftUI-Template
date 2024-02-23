//___FILEHEADER___

import SwiftUI

struct ___FILEBASENAMEASIDENTIFIER___: View {
    // MARK: - Properties
    @EnvironmentObject private var router: RouterManager
    @StateObject private var viewModel = ___FILEBASENAMEASIDENTIFIER___Model()

    var body: some View {
        containerView
            .onReceive(viewModel.state) { state in
                handleState(state)
            }
    }
}

// MARK: - State
extension ___FILEBASENAMEASIDENTIFIER___ {
    private func handleState(_ state: ___FILEBASENAMEASIDENTIFIER___Model.State) {
        print("___FILEBASENAMEASIDENTIFIER___ state: \(state)")
    }
}

// MARK: - Views
extension ___FILEBASENAMEASIDENTIFIER___ {
    private var containerView: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ___FILEBASENAMEASIDENTIFIER___()
}
