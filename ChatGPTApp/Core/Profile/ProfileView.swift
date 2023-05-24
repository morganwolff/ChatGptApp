//
//  ProfileView.swift
//  ChatGPTApp
//
//  Created by Morgan Wolff on 23/05/2023.
//

import SwiftUI

struct ProfileView: View {
  @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
      if let user = viewModel.currentUser {
        List {
          Section {
            HStack {
              Text(user.initials)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(width: 72, height: 72)
                .background(Color(.systemGray3))
                .clipShape(Circle())
              
              VStack(alignment: .leading, spacing: 4) {
                Text(user.fullname)
                  .font(.subheadline)
                  .fontWeight(.semibold)
                  .padding(.top, 4)
                
                Text(user.email)
                  .font(.footnote)
                  .foregroundColor(.gray)
              }
            }
          }
          Section("General") {
            HStack {
              SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
              Spacer()
              Text(UIApplication.appVersion ?? "N/A")
                .font(.subheadline)
                .foregroundColor(.gray)
            }
            Button {
              print("Langue")
            } label: {
              HStack {
                SettingsRowView(imageName: "text.bubble", title: "Language", tintColor: Color(.systemGray))
                Spacer()
                Image(systemName: "line.3.horizontal")
                  .foregroundColor(.gray)
              }
              .pickerStyle(.menu)
            }
            
          }
          Section("Account") {
            Button {
              viewModel.signOut()
            } label: {
              SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign out", tintColor: .red)
            }
            
            Button {
              print("delete account")
            } label: {
              SettingsRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: .red)
            }
          }
        }
      }
    }
}

extension UIApplication {
  static var appVersion: String? {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
  }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
