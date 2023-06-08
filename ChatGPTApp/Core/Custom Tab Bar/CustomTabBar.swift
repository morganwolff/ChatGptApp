//
//  CustomTabBar.swift
//  ChatGPTApp
//
//  Created by Morgan Wolff on 06/04/2023.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Tabs
    @State var isChatViewActive: Bool = false
    @State var isProfileViewActive: Bool = false
    var body: some View {
        HStack {
            Button {
                selectedTab = .chats
                isChatViewActive = true
            } label: {
                TabBarButton(buttonText: "Chats", imageName: "bubble.left", isActive: selectedTab == .chats)
            }
            .foregroundColor(Color(red: 100 / 255, green: 116 / 255, blue: 139 / 255))
            
            Button {
                // New Chat
            } label: {
                VStack (alignment: .center, spacing: 4){
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                    Text("New Chat")
                        .font(Font.custom("LexendDeca-Regular", size: 12))
                }
            }
            
            Button {
                selectedTab = .profile
                isProfileViewActive = true
            } label: {
                TabBarButton(buttonText: "Profile", imageName: "gearshape", isActive: selectedTab == .profile)
            }
            .foregroundColor(Color(red: 100 / 255, green: 116 / 255, blue: 139 / 255))
        }
        .frame(height: 82)
        .background(Color.gray.opacity(0.3))
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CustomTabBar(selectedTab: .constant(.chats))
        }
    }
}
