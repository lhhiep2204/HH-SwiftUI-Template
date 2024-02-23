//___FILEHEADER___

import Combine
import Foundation

class HomeViewModel: BaseViewModel {
    // MARK: - Enums
    enum State {
        case initial
        case logoutSuccess
        case error(message: String)
    }
    
    enum Intent {
        case logout
    }
    
    // MARK: - Properties
    let state = CurrentValueSubject<State, Never>(.initial)
    let intent = PassthroughSubject<Intent, Never>()
    
    let topics: [Topic] = [
        Topic(title: "Device",
              name: [
                "iPhone",
                "iPad",
                "Apple Watch",
                "Macbook",
                "AirPods",
                "Apple Vision Pro"
              ]),
        Topic(title: "OS",
              name: [
                "iOS",
                "iPadOS",
                "watchOS",
                "macOS",
                "visionOS"
              ])
    ]
    
    // MARK: - Constructors
    override init() {
        super.init()
        
        intent
            .sink { [weak self] action in
                guard let self = self else { return }
                
                handleAction(action)
            }
            .store(in: &subscriptions)
    }
}

// MARK: - Action
extension HomeViewModel {
    private func handleAction(_ action: Intent) {
        switch action {
        case .logout:
            state.send(.logoutSuccess)
        }
    }
}
