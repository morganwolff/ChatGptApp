//
//  ContentView.swift
//  ChatGPTApp
//
//  Created by Morgan Wolff on 06/04/2023.
//

import SwiftUI

enum Tabs{
    case chats
    case settings
}

struct ContentView: View {
  @State var selectedTab: Tabs = .settings
  @EnvironmentObject var viewModel: AuthViewModel
  
    var body: some View {
      Group {
        if viewModel.userSession != nil {
          VStack {
            switch selectedTab {
            case .chats:
              NavigationStack {
                ChatView()
              }
            case .settings:
              NavigationStack {
                ProfileView()
              }
            }
            Spacer()
            CustomTabBar(selectedTab: $selectedTab)
          }
        } else {
          LoginView()
        }
      }
    }
}

//struct ContentView: View {
//    @State var selectedTab: Tabs = .chats
//    var body: some View {
//        VStack {
//            switch selectedTab {
//            case .chats:
//                NavigationStack {
//                    ChatView()
//                }
//            case .settings:
//                NavigationStack {
//                  SettingsView()
//                }
//            }
//            //Spacer()
//            CustomTabBar(selectedTab: $selectedTab)
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
