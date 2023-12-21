//
//  DataManager.swift
//  project1
//
//  Created by User on 11/24/23.
//

import Contacts
import Foundation
import SwiftUI
// Class managing global variables
class DataManager: ObservableObject {
    // Published variables storing various data
    @Published var selectedJobID: String = ""
    @Published var selectedHours: String = ""
    @Published var allSMSs: String = ""
    @Published var allSMSBodies: [String] = []
    @Published var selectedContacts: [CNContact]? // Define as an optional array
    @Published var selectedPhoneNumber: String = UserDefaults.standard.string(forKey: "CustomPhoneNumber") ?? ""
    @Published var selectedPhoneNumber2: String = UserDefaults.standard.string(forKey: "CustomPhoneNumber2") ?? ""
    @Published var employeeData: [String: String] = [:]
    @Published var isDarkMode: Bool
    static var selectedContactName: String = "" // Global variable to store selected contact name
    @Published var selectedContactPhoneNumber = ""
    @Published var selectedContactPhoneNumber2 = ""
    @Published var selectedContactName = ""
    @Published var selectedContactName2 = ""
    @Published var selectedContact1: CNContact?
    @Published var selectedContact2: CNContact?
    
    init() {
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        //         self.selectedContact = DataManager.loadContact()
        //         self.selectedPhoneNumber = DataManager.loadPhoneNumber()
    }
    
    func toggleDarkMode() {
        isDarkMode.toggle()
        UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
    }
    // Dictionary to hold employee hours data
    
    // Method to set hours for a given employee name
    func saveEmployeeHours(name: String, hours: String) {
        employeeData[name] = hours
    }
    
    // Method to get hours for a given employee name from the dictionary
    func hoursForEmployee(_ employeeName: String) -> String {
        return employeeData[employeeName] ?? ""
    }
    
    // Array holding employee names
    let employeeNames = [
        "Anthony",
        "Brandon",
        "Brandin",
        "Bennet",
        "Chris",
        "Chuck",
        "David",
        "Derek",
        "Dennis",
        "Jason",
        "Jesse",
        "Kevin",
        // Add other employee names here
    ]
    func clearAllSMSData() {
        dataManager.allSMSs = "" // Clear the string
        dataManager.allSMSBodies = [] // Clear the array
        
    }
  

    func saveSelectedContacts(_ contacts: [CNContact]) {
        let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: contacts, requiringSecureCoding: false)
        UserDefaults.standard.set(encodedData, forKey: "selectedContactsKey")
    }
    
    func retrieveSelectedContacts() -> [CNContact]? {
        if let savedData = UserDefaults.standard.data(forKey: "selectedContactsKey"),
            let decodedContacts = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, CNContact.self], from: savedData) as? [CNContact] {
            return decodedContacts
        }
        return nil
    }
     
     func deleteSelectedContacts() {
         UserDefaults.standard.removeObject(forKey: "selectedContactsKey")
         selectedContacts = nil // Clear the selected contacts
     }
 }
 
//    
//    func saveSelectedNumbers() {
//        UserDefaults.standard.set(selectedPhoneNumber, forKey: "CustomPhoneNumber")
//        UserDefaults.standard.set(selectedPhoneNumber2, forKey: "CustomPhoneNumber2")
//    }
//    
//    func clearSelectedNumbers() {
//        selectedPhoneNumber = ""
//        selectedPhoneNumber2 = ""
//        UserDefaults.standard.removeObject(forKey: "CustomPhoneNumber")
//        UserDefaults.standard.removeObject(forKey: "CustomPhoneNumber2")
//    }
//    func clearFirstContact() {
//        selectedContactName = ""
//        selectedContactPhoneNumber = ""
//        UserDefaults.standard.removeObject(forKey: "SelectedContact1")
//    }
//    func clearSecondContact() {
//        selectedContactName2 = ""
//        selectedContactPhoneNumber2 = ""
//        UserDefaults.standard.removeObject(forKey: "SelectedContact2")
//
//        
//    }
    //
    //
    //
    //    @Published var selectedContact: CNContact {
    //           didSet {
    //               // Save to UserDefaults when selectedContact changes
    //               saveContact()
    //           }
    //       }
    //
    //       @Published var selectedPhoneNumber: String {
    //           didSet {
    //               // Save to UserDefaults when selectedPhoneNumber changes
    //               savePhoneNumber()
    //           }
    //       }
    //
    //
    //      // Function to save selectedContact to UserDefaults
    //      private func saveContact() {
    //          // Convert selectedContact to Data
    //          if let encoded = try? NSKeyedArchiver.archivedData(withRootObject: selectedContact, requiringSecureCoding: false) {
    //              UserDefaults.standard.set(encoded, forKey: "SelectedContact")
    //          }
    //      }
    //
    //      // Function to save selectedPhoneNumber to UserDefaults
    //      private func savePhoneNumber() {
    //          UserDefaults.standard.set(selectedPhoneNumber, forKey: "CustomPhoneNumber")
    //      }
    //
    //      // Function to load selectedContact from UserDefaults
    //      private static func loadContact() -> CNContact {
    //          guard let contactData = UserDefaults.standard.object(forKey: "SelectedContact") as? Data,
    //                let contact = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(contactData) as? CNContact
    //          else {
    //              return CNContact() // Return a default value if no saved data exists
    //          }
    //          return contact
    //      }
    //
    //      // Function to load selectedPhoneNumber from UserDefaults
    //      private static func loadPhoneNumber() -> String {
    //          return UserDefaults.standard.string(forKey: "CustomPhoneNumber") ?? ""
    //      }
    //  }
    

