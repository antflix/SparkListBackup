import SwiftUI
import ContactsUI

struct ContactPickerViewController: UIViewControllerRepresentable {
    @EnvironmentObject var dataManager: DataManager
    @Binding var selectedContacts: [CNContact] // Binding to track selected contacts
    
    func makeUIViewController(context: Context) -> CNContactPickerViewController {
        let picker = CNContactPickerViewController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: CNContactPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(dataManager: dataManager, selectedContacts: $selectedContacts)
    }
    
    class Coordinator: NSObject, CNContactPickerDelegate {
        var dataManager: DataManager
        @Binding var selectedContacts: [CNContact]
        
        init(dataManager: DataManager, selectedContacts: Binding<[CNContact]>) {
            self.dataManager = dataManager
            _selectedContacts = selectedContacts
        }
        
        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            selectedContacts.append(contact) // Add selected contact to the array
            dataManager.saveSelectedContacts() // Save selected contacts using your DataManager
        }
    }
}
