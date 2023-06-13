//
//  AuthViewModel.swift
//  ChatGPTApp
//
//  Created by Morgan Wolff on 24/05/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthentificationFormProtocol {
  var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
  @Published var userSession: FirebaseAuth.User?
  @Published var currentUser: User?
  @Published var showErrorAlert = false
  @Published var errorLogin: String?
  @Published var errorRegister: String?
  
  init() {
    self.userSession = Auth.auth().currentUser
    Task {
      await fetchUser()
    }
  }
  
  func signIn(withEmail email: String, password: String) async throws {
    do {
      let result = try await Auth.auth().signIn(withEmail: email, password: password)
      self.userSession = result.user
      await fetchUser()
    } catch {
      self.errorLogin = error.localizedDescription
      self.showErrorAlert = true
    }
  }
  
  func createUser(withEmail email: String, password: String, fullname: String) async throws {
    do {
      let result = try await Auth.auth().createUser(withEmail: email, password: password)
      self.userSession = result.user
      let user = User(id: result.user.uid, fullname: fullname, email: email)
      let encodedUser = try Firestore.Encoder().encode(user)
      try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
      await fetchUser() // fetch user data right after creating an user
    } catch {
      print("DEBUG: Failed to create user with error \(error.localizedDescription)")
    }
  }
  
  func signOut() {
    do {
      try Auth.auth().signOut() // sign out user on backend
      self.userSession = nil // wips out user session and takes us back to login screen
      self.currentUser = nil // wipes out currentuser data model
    } catch {
      self.errorRegister = error.localizedDescription
      self.showErrorAlert = true
      print("DEBUG: failed to sign out with error \(error.localizedDescription)")
    }
  }
  
  func deleteAccount() {
    guard let uid = self.userSession?.uid else { return }
    
    self.userSession?.delete { [weak self] error in
        if let error = error {
            print("DEBUG: Failed to delete user account with error \(error.localizedDescription)")
        } else {
            // Delete user data from Firestore
            Firestore.firestore().collection("users").document(uid).delete { error in
                if let error = error {
                    print("DEBUG: Failed to delete user data with error \(error.localizedDescription)")
                } else {
                    self?.userSession = nil
                    self?.currentUser = nil
                    print("User account and data deleted successfully.")
                }
            }
        }
    }
  }
  
  func isUserRecentlyReauthenticated() -> Bool {
      guard let user = Auth.auth().currentUser else {
          return false
      }
      let lastSignInDate = user.metadata.lastSignInDate
      let recentTimeThreshold: TimeInterval = 300 // 5 minutes
      
      if let lastSignInDate = lastSignInDate {
          let timeSinceLastSignIn = Date().timeIntervalSince(lastSignInDate)
          return timeSinceLastSignIn <= recentTimeThreshold
      }
      
      return false
  }
  
  func fetchUser() async {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
    self.currentUser = try? snapshot.data(as: User.self)
  }
}
