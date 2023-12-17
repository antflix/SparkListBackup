// ContactPickerView.swift
import SwiftUI
struct ContactsView: View {
    @EnvironmentObject var dataManager: DataManager // Access the DataManager

    @State private var isContactPickerPresented = false
    @State private var selectedContactName = ""
    @State private var selectedContactPhoneNumber = ""
    @State private var selectedContactName2 = ""
    @State private var selectedContactPhoneNumber2 = ""

    var body: some View {
        VStack {
            Button("Pick Contact") {
                self.isContactPickerPresented = true
            }
            .sheet(isPresented: $isContactPickerPresented) {
                ContactPickerViewController(selectedContactName: $selectedContactName, selectedContactPhoneNumber: $selectedContactPhoneNumber, selectedContactName2: $selectedContactName2, selectedContactPhoneNumber2: $selectedContactPhoneNumber2) // Update to include additional bindings
            }

            if !selectedContactName.isEmpty && !selectedContactPhoneNumber.isEmpty {
                Text("Selected Contact 1: \(dataManager.selectedContactName)")
                Text("Phone Number 1: \(dataManager.selectedContactPhoneNumber)")
            }
            if !selectedContactName2.isEmpty && !selectedContactPhoneNumber2.isEmpty {
                Text("Selected Contact 2: \(dataManager.selectedContactName2)")
                Text("Phone Number 2: \(dataManager.selectedContactPhoneNumber2)")
            }
        }
    }
}
