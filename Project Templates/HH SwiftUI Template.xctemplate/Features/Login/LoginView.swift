//___FILEHEADER___

import SwiftUI

struct LoginView: View {
    
    // MARK: - Enum
    enum FocusField {
        case username, password
    }
    
    // MARK: - Properties
    @EnvironmentObject private var router: RouterManager
    @StateObject private var viewModel = LoginViewModel()
    @AppStorage(UserDefaultKey.isLogin.rawValue) private var isLogin: Bool = false
    
    @FocusState private var focusField: FocusField?
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        containerView
            .onReceive(viewModel.state) { state in
                handleState(state)
            }
            .alert(isPresented: $showAlert) {
                AlertView().showErrorAlert(message: alertMessage)
            }
    }
    
}

// MARK: - State
extension LoginView {
    
    private func handleState(_ state: LoginViewModel.State) {
        switch state {
        case .initial:
            focusField = .username
            viewModel.intent.send(.validation)
        case .loginSuccess:
            isLogin = true
            router.updateRoot(.home)
        case .error(let message):
            alertMessage = message
            showAlert = true
        }
    }
    
}

// MARK: - Views
extension LoginView {
    
    private var containerView: some View {
        ZStack {
            loginView
            loadingView
        }
        .ignoresSafeArea(.keyboard)
    }
    
    private var loginView: some View {
        VStack(spacing: 50) {
            Spacer()
            titleView
            inputView
            buttonView
            Spacer()
            authorView
        }
    }
    
    private var titleView: some View {
        Text(StringConstant.LOGIN)
            .font(.bold(.largeTitle)())
    }
    
    private var inputView: some View {
        VStack(spacing: 20) {
            TextField(StringConstant.USER_NAME,
                      text: $viewModel.username)
            .focused($focusField, equals: .username)
            .textFieldStyle(CustomTextFieldStyle())
            .submitLabel(.next)
            .onSubmit {
                focusField = .password
            }
            SecureField(StringConstant.PASSWORD,
                        text: $viewModel.password)
            .focused($focusField, equals: .password)
            .textFieldStyle(CustomTextFieldStyle())
            .submitLabel(.done)
        }
        .padding(EdgeInsets(top: 0,
                            leading: 50,
                            bottom: 0,
                            trailing: 50))
    }
    
    private var buttonView: some View {
        Button(StringConstant.LOGIN) {
            focusField = .none
            viewModel.intent.send(.login)
        }
        .buttonStyle(CustomButtonStyle())
        .disabled(!viewModel.isValid)
    }
    
    private var authorView: some View {
        HStack {
            Spacer()
            Text("Created by: Hiep Le\nhttps://github.com/lhhiep2204/SwiftUI-Combine-MVI")
                .multilineTextAlignment(.trailing)
                .font(.bold(.footnote)())
                .padding(.trailing, 20)
        }
    }
    
    @ViewBuilder
    private var loadingView: some View {
        if viewModel.isLoading {
            LoadingView()
        } else {
            EmptyView()
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginView()
    }
    
}
