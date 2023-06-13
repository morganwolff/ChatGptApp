//
//  InputView.swift
//  ChatGPTApp
//
//  Created by Morgan Wolff on 23/05/2023.
//

import SwiftUI

struct InputView: View {
  @Binding var text: String
  let title: LocalizedStringKey
  let placeholder: LocalizedStringKey
  var isSecureField = false
  
  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text(title)
        .foregroundColor(Color(.darkGray))
        .fontWeight(.semibold)
        .font(.footnote)
      if isSecureField {
        SecureField(placeholder, text: $text)
          .font(.system(size: 14))
      } else {
        TextField(placeholder, text: $text)
          .font(.system(size: 14))
      }
      Divider()
        .background(.black)
    }
  }
}
