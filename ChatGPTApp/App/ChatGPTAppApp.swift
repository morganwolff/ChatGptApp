//
//  ChatGPTAppApp.swift
//  ChatGPTApp
//
//  Created by Morgan Wolff on 06/04/2023.
//

import SwiftUI
import Firebase

@main
struct ChatGPTAppApp: App {
  @StateObject var viewModel = AuthViewModel()
  
  init() {
    FirebaseApp.configure()
  }
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(viewModel)
        }
    }
}
