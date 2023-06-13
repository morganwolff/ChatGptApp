//
//  SettingsRowView.swift
//  ChatGPTApp
//
//  Created by Morgan Wolff on 23/05/2023.
//

import SwiftUI

struct SettingsRowView: View {
  let imageName: String
  let title: LocalizedStringKey
  let tintColor: Color
  
    var body: some View {
      HStack(spacing: 12) {
        Image(systemName: imageName)
          .imageScale(.small)
          .font(.title)
          .foregroundColor(tintColor)
        Text(title)
          .font(.subheadline)
          .foregroundColor(.black)

      }
    }
}

struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
      SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
    }
}
