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
          InputView(text: $email, title: "signin.page.email.title".localize(), placeholder: "signin.page.email.placeholder".localize())
            .autocapitalization(.none)
          InputView(text: $password, title: "signin.page.password.title".localize(), placeholder: "signin.page.pasword.placeholder".localize(), isSecureField: true)
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
            Text("signin.page.signin.button".localize())
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
            Text("signin.page.signup.button.text1".localize())
            Text("signin.page.signup.button.text2".localize())
              .fontWeight(.bold)
          }
          .font(.system(size: 14))
        }
      }
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
