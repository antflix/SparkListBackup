// ContactPickerView.swift
import SwiftUI
struct ContactsView: View {
    @EnvironmentObject var dataManager: DataManager // Access the DataManager

    @State private var isContactPickerPresented = false
    @State private var selectedContactPhoneNumber = ""
    @State private var selectedContactName2 = ""
    @State private var selectedContactPhoneNumber2 = ""

    var body: some View {
        VStack {
            Button("Pick Contact") {
                self.isContactPickerPresented = true
            }
            .sheet(isPresented: $isContactPickerPresented) {
                ContactPickerViewController(selectedContactName: $dataManager.selectedContactName, selectedContactPhoneNumber: $dataManager.selectedContactPhoneNumber, selectedContactName2: $dataManager.selectedContactName2, selectedContactPhoneNumber2: $dataManager.selectedContactPhoneNumber2) // Update to include additional bindings
            }

            if !dataManager.selectedContactName.isEmpty && !dataManager.selectedContactPhoneNumber.isEmpty {
                Text("Selected Contact 1: \(dataManager.selectedContactName)")
                Text("Phone Number 1: \(dataManager.selectedContactPhoneNumber)")
            }
            if !dataManager.selectedContactName2.isEmpty && !dataManager.selectedContactPhoneNumber2.isEmpty {
                Text("Selected Contact 2: \(dataManager.selectedContactName2)")
                Text("Phone Number 2: \(dataManager.selectedContactPhoneNumber2)")
            }
        }
    }
}
