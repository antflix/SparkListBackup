import SwiftUI
import ContactsUI
// ContactPickerViewController.swift
struct ContactPickerViewController: UIViewControllerRepresentable {
    @Binding var selectedContactName: String
    @Binding var selectedContactPhoneNumber: String
    @Binding var selectedContactName2: String // Additional binding for second contact name
    @Binding var selectedContactPhoneNumber2: String // Additional binding for second contact phone number

    func makeUIViewController(context: Context) -> CNContactPickerViewController {
        let picker = CNContactPickerViewController()
        picker.delegate = context.coordinator
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
            let fullName = CNContactFormatter.string(from: contact, style: .fullName) ?? ""
            let phoneNumbers = contact.phoneNumbers.first?.value.stringValue ?? ""
            
            // Save the first selected contact's details
            if self.parent.selectedContactName.isEmpty {
                self.parent.selectedContactName = fullName
                self.parent.selectedContactPhoneNumber = phoneNumbers
            } else { // Save the second selected contact's details
                self.parent.selectedContactName2 = fullName
                self.parent.selectedContactPhoneNumber2 = phoneNumbers
            }
        }
    }
}
