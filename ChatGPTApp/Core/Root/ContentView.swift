//
//  ContentView.swift
//  ChatGPTApp
//
//  Created by Morgan Wolff on 06/04/2023.
//

import SwiftUI

enum Tabs{
    case chats
    case profile
}

struct ContentView: View {
  @State var selectedTab: Tabs = .profile
  @EnvironmentObject var viewModel: AuthViewModel
  
    var body: some View {
      Group {
        if (viewModel.userSession != nil) {
          VStack (spacing: 0) {
            switch selectedTab {
            case .chats:
              NavigationStack {
                ChatView()
              }
            case .profile:
              NavigationStack {
                ProfileView()
              }
            }
            CustomTabBar(selectedTab: $selectedTab)
          }
        } else {
          LoginView()
        }
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
