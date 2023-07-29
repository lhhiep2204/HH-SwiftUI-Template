//___FILEHEADER___

import Foundation

enum AppEnvironment {
    case development, staging, production
}

struct Configs {
    
    struct Environment {
        static let current: AppEnvironment = {
            /// App environment: set in `Build Settings` ~> `Other Swift Flags`.
            #if DEVELOPMENT
                return .development
            #elseif STAGING
                return .staging
            #else
                return .production
            #endif
        }()
    }
    
    struct API {
        static let baseURL: String = {
            switch Configs.Environment.current {
            case .development:
                return "https://newsapi.org/v2"
            case .staging:
                return "https://newsapi.org/v2"
            case .production:
                return "https://newsapi.org/v2"
            }
        }()
    }
    
}

extension Configs {
    
    static let API_KEY = "fe815691c8a0404ea302ee4afec37221"
    
}
