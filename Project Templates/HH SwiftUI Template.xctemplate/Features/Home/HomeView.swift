//___FILEHEADER___

import SwiftUI

struct HomeView: View {
    
    // MARK: - Properties
    @EnvironmentObject private var router: RouterManager
    @StateObject private var viewModel = HomeViewModel()
    @AppStorage(UserDefaultKey.isLogin.rawValue) private var isLogin: Bool = false
    
    @State private var showActionSheet = false
    
    var body: some View {
        containerView
            .onReceive(viewModel.state) { state in
                handleState(state)
            }
            .confirmationDialog(StringConstant.LOGOUT_CONFIRM,
                                isPresented: $showActionSheet,
                                titleVisibility: .visible) {
                Button(StringConstant.LOGOUT, role: .destructive) {
                    viewModel.intent.send(.logout)
                }
            }
    }
    
}

// MARK: - State
extension HomeView {
    
    private func handleState(_ state: HomeViewModel.State) {
        switch state {
        case .logoutSuccess:
            isLogin = false
            router.updateRoot(.login)
        default:
            break
        }
    }
    
}

// MARK: - Views
extension HomeView {
    
    private var containerView: some View {
        listView
            .navigationTitle(StringConstant.TOPIC)
    }
    
    private var listView: some View {
        List {
            ForEach(viewModel.topics) { topic in
                Section(topic.title) {
                    ForEach(topic.name, id: \.self) { name in
                        HStack {
                            Text(name)
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            router.push(.detail(topic: name))
                        }
                    }
                }
            }
            
            Section {
                buttonView
            } footer: {
                authorView
            }
        }
    }
    
    private var buttonView: some View {
        Button(StringConstant.LOGOUT) {
            showActionSheet = true
        }
    }
    
    private var authorView: some View {
        VStack {
            Spacer()
            Text("Created by: Hiep Le\nhttps://github.com/lhhiep2204/SwiftUI-Combine-MVI")
                .font(.bold(.footnote)())
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView()
    }
    
}
