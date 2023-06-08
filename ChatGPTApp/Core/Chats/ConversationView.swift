//
//  ConversationView.swift
//  ChatGPTApp
//
//  Created by Morgan Wolff on 06/04/2023.
//

import SwiftUI

struct ConversationView: View {
    @State var Title: String = "Hello les couz"
    var body: some View {
        HStack {
            Image(systemName: "bubble.left")
                .padding()
                .foregroundColor(.white)
            Spacer()
            Text(Title)
                .foregroundColor(.white)
            Spacer()
            Button {
                // Edit Title
            } label: {
                Image(systemName: "pencil.line")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
            }
            .padding()
            
            Button {
                // Delete Conversation
            } label: {
                Image(systemName: "trash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
            }
            .padding()
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(Color.white.opacity(0.2))
        .cornerRadius(10)
        .padding(.leading, 4)
        .padding(.trailing, 4)
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView()
    }
}
