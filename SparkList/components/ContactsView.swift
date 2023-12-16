
// ContactPickerView.swift
import SwiftUI
struct ContactsView: View {
    @EnvironmentObject var dataManager: DataManager

    @State private var isContactPickerPresented = false // State variable to present contact picker
    @State private var selectedContactName = "" // State variable to store selected contact name
    @State private var selectedContactPhoneNumber = "" // State variable to store selected contact phone number

    var body: some View {
        VStack {
            Button("Pick Contact") {
                isContactPickerPresented = true // Present contact picker when button is tapped
            }
            .sheet(isPresented: $isContactPickerPresented) {
                ContactPickerViewController(selectedContactName: $selectedContactName, selectedContactPhoneNumber: $selectedContactPhoneNumber) // Present ContactPickerViewController as a sheet
            }

            if !selectedContactName.isEmpty && !selectedContactPhoneNumber.isEmpty {
                Text("Selected Contact: \(selectedContactName)")
                Text("Contact Phone Number: \(selectedContactPhoneNumber)")
            }
        }
    }
}
