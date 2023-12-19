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
            // Call this function when a contact is selected
            // Update DataManager directly when a contact is selected
            if dataManager.selectedContact1 == nil {
                dataManager.selectedContactName = fullName
                dataManager.selectedContactPhoneNumber = phoneNumbers
                dataManager.selectedContact1 = contact
                dataManager.saveContacts() // Save contacts after updating
            } else {
                dataManager.selectedContactName2 = fullName
                dataManager.selectedContactPhoneNumber2 = phoneNumbers
                dataManager.selectedContact2 = contact
                dataManager.saveContacts() // Save contacts after updating
            }
        }
    }
}
