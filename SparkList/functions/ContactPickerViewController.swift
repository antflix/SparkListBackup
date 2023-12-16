// ContactPickerViewController.swift
import SwiftUI
import ContactsUI
struct ContactPickerViewController: UIViewControllerRepresentable {
    @Binding var selectedContactName: String // Binding to update selected contact name
    @Binding var selectedContactPhoneNumber: String // Binding to update selected contact phone number

    func makeUIViewController(context: Context) -> CNContactPickerViewController {
        let picker = CNContactPickerViewController()
        picker.delegate = context.coordinator // Set delegate to coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: CNContactPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    class Coordinator: NSObject, CNContactPickerDelegate {
        let parent: ContactPickerViewController

        init(parent: ContactPickerViewController) {
            self.parent = parent
        }

        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            // Update selected contact name and phone number when a contact is selected
            let fullName = CNContactFormatter.string(from: contact, style: .fullName) ?? ""
            let phoneNumbers = contact.phoneNumbers.first?.value.stringValue ?? ""
            
            // Save selected contact's name and phone number to DataManager
            DataManager.selectedContactName = fullName
            DataManager.selectedContactPhoneNumber = phoneNumbers

            // Update the bindings to display the selected contact's details in the ContactPickerView
            self.parent.selectedContactName = fullName
            self.parent.selectedContactPhoneNumber = phoneNumbers
        }
    }
}
