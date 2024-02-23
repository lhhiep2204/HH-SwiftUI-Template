//___FILEHEADER___

import SwiftUI

struct DetailView: View {
    // MARK: - Properties
    @StateObject private var viewModel = DetailViewModel()

    let topic: String

    var body: some View {
        containerView
            .onReceive(viewModel.state) { state in
                handleState(state)
            }
    }
}

// MARK: - State
extension DetailView {
    private func handleState(_ state: DetailViewModel.State) {
        switch state {
        case .initial:
            viewModel.intent.send(.getNews(topic: topic))
        case .getNewsSuccess:
            print(viewModel.articles)
        case .error(let message):
            print("Error \(message)")
        }
    }
}

// MARK: - Views
extension DetailView {
    private var containerView: some View {
        listView
            .navigationTitle(topic)
    }

    private var listView: some View {
        List(viewModel.articles, id: \.self) { article in
            DetailItem(article: article)
        }
        .refreshable {
            viewModel.intent.send(.getNews(topic: topic))
        }
    }
}

#Preview {
    DetailView(topic: "iOS")
}
