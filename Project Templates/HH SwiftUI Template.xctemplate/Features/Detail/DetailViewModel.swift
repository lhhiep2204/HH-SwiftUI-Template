//___FILEHEADER___

import Combine
import Foundation

class DetailViewModel: BaseViewModel {
    
    // MARK: - Enums
    enum State {
        case initial
        case getNewsSuccess
        case error(message: String)
    }
    
    enum Intent {
        case getNews(topic: String)
    }
    
    // MARK: - Properties
    let state = CurrentValueSubject<State, Never>(.initial)
    let intent = PassthroughSubject<Intent, Never>()
    
    private let service = NewsService()
    
    @Published var articles = [Article]()
    
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
extension DetailViewModel {
    
    private func handleAction(_ action: Intent) {
        switch action {
        case .getNews(let topic):
            getNews(topic)
        }
    }
    
}

// MARK: - Methods
extension DetailViewModel {
    
    private func getNews(_ topic: String) {
        service.getNews(topic: topic)
            .sink { [weak self] completion in
                guard let self else { return }
                
                if case .failure(let error) = completion {
                    state.send(.error(message: error.message))
                }
            } receiveValue: { [weak self] value in
                guard let self else { return }
                articles = value.articles ?? []
                state.send(.getNewsSuccess)
            }
            .store(in: &subscriptions)
    }
    
}
