//___FILEHEADER___

import Combine
import Foundation

class BaseViewModel: ObservableObject {
    // MARK: - Properties
    var subscriptions = Set<AnyCancellable>()
    
    deinit {
        subscriptions.removeAll()
    }
}
