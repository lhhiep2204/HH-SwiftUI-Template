//___FILEHEADER___

import SwiftUI

struct DetailItem: View {
    // MARK: - Properties
    let article: Article

    var body: some View {
        containerView
    }
}

// MARK: - Views
extension DetailItem {
    private var containerView: some View {
        VStack(alignment: .leading) {
            Text(article.title ?? .empty)
                .font(.bold(.headline)())
                .padding(.bottom, 5)
            Text(article.description ?? .empty)
                .font(.subheadline)
            readMoreView
            imageView
        }
    }

    @ViewBuilder
    private var imageView: some View {
        if let urlString = article.urlToImage,
           let url = URL(string: urlString) {
            CacheAsyncImage(url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 16)
                case .failure(_):
                    EmptyView()
                case .empty:
                    HStack {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                        Spacer()
                    }
                    .padding(.bottom, 16)
                @unknown default:
                    EmptyView()
                }
            }
        }
    }

    @ViewBuilder
    private var readMoreView: some View {
        if let url = article.url {
            Text(.init("[Read more](\(url))"))
                .font(.footnote)
        }
    }
}

#Preview {
    DetailItem(article: Article.mock())
}
