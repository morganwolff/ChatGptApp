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
          Section("profile.page.general.section.title".localize()) {
            HStack {
              SettingsRowView(imageName: "gear", title: "profile.page.general.version".localize(), tintColor: Color(.systemGray))
              Spacer()
              Text(UIApplication.appVersion ?? "N/A")
                .font(.subheadline)
                .foregroundColor(.gray)
            }
            Button {
              print("Langue")
            } label: {
              HStack {
                SettingsRowView(imageName: "text.bubble", title: "profile.page.general.language".localize(), tintColor: Color(.systemGray))
                Spacer()
                Image(systemName: "line.3.horizontal")
                  .foregroundColor(.gray)
              }
              .pickerStyle(.menu)
            }
            
          }
          Section("profile.page.account.section.title".localize()) {
            Button {
              viewModel.signOut()
            } label: {
              SettingsRowView(imageName: "arrow.left.circle.fill", title: "profile.page.account.signout".localize(), tintColor: .red)
            }
            
            Button {
              print("delete account")
            } label: {
              SettingsRowView(imageName: "xmark.circle.fill", title: "profile.page.account.deleteaccount".localize(), tintColor: .red)
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
