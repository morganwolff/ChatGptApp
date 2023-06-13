//
//  LocalizationManager.swift
//  ChatGPTApp
//
//  Created by Morgan Wolff on 08/06/2023.
//

import Foundation

struct LocalizationManager {
    static let selectedLanguageKey = "SelectedLanguage"
    
    static func setCurrentLanguage(_ language: String) {
        UserDefaults.standard.set(language, forKey: selectedLanguageKey)
    }
    
    static func getCurrentLanguage() -> String? {
        return UserDefaults.standard.string(forKey: selectedLanguageKey)
    }
    
    static func changeLanguage(to language: String) {
        setCurrentLanguage(language)
        
        // Restart the app or reload the UI to apply the language change
        NotificationCenter.default.post(name: NSNotification.Name("LanguageChanged"), object: nil)
    }
}
