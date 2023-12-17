import SwiftUI
import ContactsUI

struct ContactPickerViewController: UIViewControllerRepresentable {
    @EnvironmentObject var dataManager: DataManager

    func makeUIViewController(context: Context) -> CNContactPickerViewController {
        let picker = CNContactPickerViewController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: CNContactPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(dataManager: dataManager)
    }

    class Coordinator: NSObject, CNContactPickerDelegate {
        var dataManager: DataManager

        init(dataManager: DataManager) {
            self.dataManager = dataManager
        }

        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            let fullName = CNContactFormatter.string(from: contact, style: .fullName) ?? ""
            let phoneNumbers = contact.phoneNumbers.first?.value.stringValue ?? ""

            // Update DataManager directly when a contact is selected
            if dataManager.selectedContactName.isEmpty {
                dataManager.selectedContactName = fullName
                dataManager.selectedContactPhoneNumber = phoneNumbers
            } else {
                dataManager.selectedContactName2 = fullName
                dataManager.selectedContactPhoneNumber2 = phoneNumbers
            }
        }
    }
}

