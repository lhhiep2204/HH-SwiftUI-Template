//___FILEHEADER___

import Foundation

struct Article: Decodable, Hashable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}

extension Article {
    static func mock() -> Article {
        Article(author: "Jon Fingas",
                title: "Modders thought it would be fun to make a folding iPhone",
                description: "You don\'t have wait for Apple to see what a foldable iPhone would look like in practice. China-based The Aesthetics of Science and Technology (AST) claims to have built a folding iPhone through heavy modifications. The engineers say they created the one-off w…",
                url: "https://www.engadget.com/folding-iphone-unofficial-171559538.html",
                urlToImage: "https://s.yimg.com/os/creatr-uploaded-images/2022-11/5183fe30-6048-11ed-aed0-07edb649475b",
                publishedAt: "2022-11-09T17:15:59Z")
    }
}
