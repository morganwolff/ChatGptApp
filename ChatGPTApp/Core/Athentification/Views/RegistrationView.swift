//
//  RegistrationView.swift
//  ChatGPTApp
//
//  Created by Morgan Wolff on 23/05/2023.
//

import SwiftUI

struct RegistrationView: View {
  @State private var email = ""
  @State private var fullname =  ""
  @State private var password = ""
  @State private var confirmpassword =  ""
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var viewModel: AuthViewModel
  
    var body: some View {
      VStack {
        //image
        Image("Login_logo")
          .resizable()
          .scaledToFill()
          .frame(width: 120, height: 120)
          .padding(.vertical, 32)
        
        VStack (spacing: 24){
          InputView(text: $email,
                    title: "signup.page.email.title".localize(),
                    placeholder: "signup.page.email.placeholder".localize())
            .autocapitalization(.none)
          
          InputView(text: $fullname,
                    title: "signup.page.fullname.title".localize(),
                    placeholder: "signup.page.fullname.placeholder".localize())
          
          InputView(text: $password,
                    title: "signup.page.password.title".localize(),
                    placeholder: "signup.page.pasword.placeholder".localize(),
                    isSecureField: true)
            .autocapitalization(.none)
          
          ZStack (alignment: .trailing){
            InputView(text: $confirmpassword,
                      title: "signup.page.confirmpassword.title".localize(),
                      placeholder: "signup.page.confirmpassword.placeholder".localize(),
                      isSecureField: true)
              .autocapitalization(.none)
            if !password.isEmpty && !confirmpassword.isEmpty {
              if password == confirmpassword {
                Image(systemName: "checkmark.circle.fill")
                  .imageScale(.large)
                  .fontWeight(.bold)
                  .foregroundColor(Color(.systemGreen))
              } else {
                Image(systemName: "xmark.circle.fill")
                  .imageScale(.large)
                  .fontWeight(.bold)
                  .foregroundColor(Color(.systemRed))
              }
            }
          }
        }
        .padding(.horizontal)
        .padding(.top, 12)
        
        // Sign up Button
        Button {
          Task {
            try await viewModel.createUser(withEmail: email, password: password, fullname: fullname)
          }
        } label: {
          HStack {
            Text("signup.page.signin.button".localize())
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
        
        // Return to Sign In page
        Button {
          dismiss()
        } label: {
          HStack (spacing: 3){
            Text("signup.page.signup.button.text1".localize())
            Text("signup.page.signup.button.text2".localize())
              .fontWeight(.bold)
          }
          .font(.system(size: 14))
        }

      }
    }
}

// MARK: - AuthentificationFormProtocol

extension RegistrationView: AuthentificationFormProtocol {
  var formIsValid: Bool {
    return !email.isEmpty
    && email.contains("@")
    && !password.isEmpty
    && password.count > 6
    && confirmpassword == password
    && !fullname.isEmpty
  }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
