//
//  ChatView.swift
//  ChatGPTApp
//
//  Created by Morgan Wolff on 06/04/2023.
//

import SwiftUI

struct ChatView: View {
    var body: some View {
        VStack {
            Text(LocalizedStringKey("chats.page.title"))
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
