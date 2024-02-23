//___FILEHEADER___

import Combine
import Foundation

class ___FILEBASENAMEASIDENTIFIER___: BaseViewModel {
    // MARK: - Enums
    enum State {
        case initial
        case error(message: String)
    }

    enum Intent {
        case actionX
    }

    // MARK: - Properties
    let state = CurrentValueSubject<State, Never>(.initial)
    let intent = PassthroughSubject<Intent, Never>()

    // MARK: - Constructors
    override init() {
        super.init()

        intent
            .sink { [weak self] action in
                guard let self else { return }

                handleAction(action)
            }
            .store(in: &subscriptions)
    }
}

// MARK: - Action
extension ___FILEBASENAMEASIDENTIFIER___ {
    private func handleAction(_ action: Intent) {
        switch action {
        case .actionX:
            print("___FILEBASENAMEASIDENTIFIER___ action - actionX")
        }
    }
}
