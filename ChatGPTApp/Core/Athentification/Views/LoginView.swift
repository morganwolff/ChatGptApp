//
//  LoginView.swift
//  ChatGPTApp
//
//  Created by Morgan Wolff on 23/05/2023.
//

import SwiftUI

struct LoginView: View {
  @State private var email = ""
  @State private var password =  ""
  @State private var showAlert = false
  @EnvironmentObject var viewModel: AuthViewModel
  
  var body: some View {
    NavigationStack {
      VStack {
        //image
        Image("Login_logo")
          .resizable()
          .scaledToFill()
          .frame(width: 120, height: 120)
          .padding(.vertical, 32)
        
        //form fields
        VStack(spacing: 24) {
          InputView(text: $email, title: LocalizedStringKey("signin.page.email.title"), placeholder: LocalizedStringKey("signin.page.email.placeholder"))
            .autocapitalization(.none)
          InputView(text: $password, title: LocalizedStringKey("signin.page.password.title"), placeholder: LocalizedStringKey("signin.page.pasword.placeholder"), isSecureField: true)
        }
        .padding(.horizontal)
        .padding(.top, 12)
        
        //button
        Button {
          Task {
            try await viewModel.signIn(withEmail: email, password: password)
          }
        } label: {
          HStack {
            Text(LocalizedStringKey("signin.page.signin.button"))
              .fontWeight(.semibold)
            Image(systemName: "arrow.right")
          }
          .foregroundColor(.white)
          .frame(width: UIScreen.main.bounds.width - 32, height: 48)
        }
        .background(Color(.systemBlue).cornerRadius(10))
        .disabled(!formIsValid)
        .opacity(formIsValid ? 1 : 0.5)
        .padding(.top, 24)

        Spacer()
        
        //signin
        NavigationLink {
          RegistrationView()
            .navigationBarBackButtonHidden(true)
        } label: {
          HStack (spacing: 3){
            Text(LocalizedStringKey("signin.page.signup.button.text1"))
            Text(LocalizedStringKey("signin.page.signup.button.text2"))
              .fontWeight(.bold)
          }
          .font(.system(size: 14))
        }
      }
    }
    .alert(isPresented: $showAlert) {
        Alert(
            title: Text("Error"),
            message: Text(viewModel.errorLogin ?? ""),
            dismissButton: .default(Text("OK")) {
                // Handle alert dismissal if needed
            }
        )
    }
    .onChange(of: viewModel.showErrorAlert) { showErrorAlert in
      showAlert = showErrorAlert
    }
  }
}

// MARK: - AuthentificationFormProtocol

extension LoginView: AuthentificationFormProtocol {
  var formIsValid: Bool {
    return !email.isEmpty
    && email.contains("@")
    && !password.isEmpty
    && password.count > 6
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
