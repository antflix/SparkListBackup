//
//  extensions.swift
//  SparkList
//
//  Created by User on 12/8/23.
//


import SwiftUI

struct AppearanceModeKey: EnvironmentKey {
    static var defaultValue: ColorScheme = .light// Default value is light mode
}

extension EnvironmentValues {
    var appearanceMode: ColorScheme {
        get { self[AppearanceModeKey.self] }
        set { self[AppearanceModeKey.self] = newValue }
    }
}
extension String {
    func removeNonNumeric() -> String {
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}

extension DataManager {
    // Function to check if contacts are saved in UserDefaults
    func hasSavedContacts() -> Bool {
        // Check if both contacts are present in UserDefaults
        return UserDefaults.standard.object(forKey: "SelectedContact1") != nil &&
               UserDefaults.standard.object(forKey: "SelectedContact2") != nil
    }
}
