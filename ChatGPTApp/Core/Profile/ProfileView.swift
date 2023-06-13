//
//  ProfileView.swift
//  ChatGPTApp
//
//  Created by Morgan Wolff on 23/05/2023.
//

import SwiftUI

struct ProfileView: View {
  @EnvironmentObject var viewModel: AuthViewModel
  @State var showingAlert = false
  @State var alertType: AlertType = .none
  @State var showingSignOutAlert = false
  
  enum AlertType {
    case deleteConfirmation
    case reAuthConfirmation
    case none
  }
  
  var body: some View {
    List {
      Section {
        HStack {
          Text(viewModel.currentUser?.initials ?? "")
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(width: 72, height: 72)
            .background(Color(.systemGray3))
            .clipShape(Circle())
          
          VStack(alignment: .leading, spacing: 4) {
            Text(viewModel.currentUser?.fullname ?? "")
              .font(.subheadline)
              .fontWeight(.semibold)
              .padding(.top, 4)
            
            Text(viewModel.currentUser?.email ?? "")
              .font(.footnote)
              .foregroundColor(.gray)
          }
        }
      }
      //MARK: - general section
      Section(LocalizedStringKey("profile.page.general.section.title")) {
        HStack {
          SettingsRowView(imageName: "gear", title: LocalizedStringKey("profile.page.general.version"), tintColor: Color(.systemGray))
          Spacer()
          Text(UIApplication.appVersion ?? "N/A")
            .font(.subheadline)
            .foregroundColor(.gray)
        }
        
        Button {
          print("langue")
        } label: {
          HStack {
            SettingsRowView(imageName: "text.bubble", title: LocalizedStringKey("profile.page.general.language"), tintColor: Color(.systemGray))
            Spacer()
            Image(systemName: "chevron.right")
              .foregroundColor(.gray)
          }
        }
      }
      //MARK: - Account section
      Section(LocalizedStringKey("profile.page.account.section.title")) {
        Button {
          showingSignOutAlert = true
        } label: {
          SettingsRowView(imageName: "arrow.left.circle.fill", title: LocalizedStringKey("profile.page.account.signout"), tintColor: .red)
        }
        .alert(isPresented: $showingSignOutAlert) {
          Alert(
            title: Text(LocalizedStringKey("profile.page.account.signout.alert.title")),
            message: Text(LocalizedStringKey("profile.page.account.signout.alert.message")),
            primaryButton: .destructive(
              Text(LocalizedStringKey("profile.page.account.signout.alert.primaryButton")),
              action: {
                viewModel.signOut()
              }
            ),
            secondaryButton: .cancel(Text(LocalizedStringKey("profile.page.account.signout.alert.secondaryButton")))
          )
        }
        
        Button {
          alertType = .none
          if viewModel.isUserRecentlyReauthenticated() {
            alertType = .deleteConfirmation
          } else {
            alertType = .reAuthConfirmation
          }
          
          showingAlert = true
        } label: {
          SettingsRowView(imageName: "xmark.circle.fill", title: LocalizedStringKey("profile.page.account.deleteaccount"), tintColor: .red)
        }
        .alert(isPresented: $showingAlert) {
          switch alertType {
          case .deleteConfirmation:
            return Alert(
              title: Text(LocalizedStringKey("profile.page.account.deleteaccount.alert.title")),
              message: Text(LocalizedStringKey("profile.page.account.deleteaccount.alert.message")),
              primaryButton: .destructive(
                Text(LocalizedStringKey("profile.page.account.deleteaccount.alert.primaryButton")),
                action: {
                  viewModel.deleteAccount()
                }
              ),
              secondaryButton: .cancel(Text(LocalizedStringKey("profile.page.account.deleteaccount.alert.secondaryButton")))
            )
            
          case .reAuthConfirmation:
            return Alert(
              title: Text(LocalizedStringKey("profile.page.account.reauthentification.alert.title")),
              message: Text(LocalizedStringKey("profile.page.account.reauthentification.alert.message")),
              primaryButton: .destructive(
                Text(LocalizedStringKey("profile.page.account.reauthentification.alert.primaryButton")),
                action: {
                  viewModel.signOut()
                }
              ),
              secondaryButton: .cancel(Text(LocalizedStringKey("profile.page.account.reauthentification.alert.secondaryButton")))
            )
            
          case .none:
            return Alert(title: Text(""))
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

