//___FILEHEADER___

import Combine
import Foundation

class LoginViewModel: BaseViewModel {
    
    // MARK: - Enums
    enum State {
        case initial
        case loginSuccess
        case error(message: String)
    }
    
    enum Intent {
        case validation
        case login
    }
    
    // MARK: - Properties
    let state = CurrentValueSubject<State, Never>(.initial)
    let intent = PassthroughSubject<Intent, Never>()
    
    @Published var username = ""
    @Published var password = ""
    @Published var isValid = false
    @Published var isLoading = false
    
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
extension LoginViewModel {
    
    private func handleAction(_ action: Intent) {
        switch action {
        case .validation:
            validatedCredentials
                .assign(to: &$isValid)
        case .login:
            isLoading = true
            login()
        }
    }
    
}

// MARK: - Validation
extension LoginViewModel {
    
    private var validatedCredentials: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest(validateUsername, validatePassword)
            .map { $0 && $1 }
            .eraseToAnyPublisher()
    }
    
    private var validateUsername: AnyPublisher<Bool, Never> {
        return $username
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    private var validatePassword: AnyPublisher<Bool, Never> {
        return $password
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
}

// MARK: - Methods
extension LoginViewModel {
    
    private func login() {
        Just(())
            .delay(for: .seconds(2), scheduler: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                isLoading = false
                if username.count > 3 {
                    state.send(.loginSuccess)
                } else {
                    state.send(.error(message: StringConstant.TRY_AGAIN))
                }
            }
            .store(in: &subscriptions)
    }
    
}
