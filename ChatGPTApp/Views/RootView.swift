//
//  RootViewView.swift
//  ChatGPTApp
//
//  Created by Morgan Wolff on 06/04/2023.
//

import SwiftUI

enum Tabs{
    case chats
    case settings
}


struct RootView: View {
    @State var selectedTab: Tabs = .chats
    var body: some View {
        VStack {
            switch selectedTab {
            case .chats:
                NavigationStack {
                    ChatView()
                }
            case .settings:
                NavigationStack {
                  SettingsView()
                }
            }
            //Spacer()
            CustomTabBar(selectedTab: $selectedTab)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
