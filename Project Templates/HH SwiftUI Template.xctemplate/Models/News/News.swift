//___FILEHEADER___

import Foundation

struct News: Decodable {
    let status: String
    let articles: [Article]?
}
