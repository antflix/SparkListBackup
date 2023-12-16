import SwiftUI
import ContactsUI

struct ContactsView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var isPresentingContacts = false
    @State private var selectedContact: CNContact?
    
    var body: some View {
        VStack {
            Button("Select Contact") {
                // Set isPresentingContacts to true to present the contact picker
                isPresentingContacts = true
            }
            Text("Currently Selected Contact: \(dataManager.selectedPhoneNumber)")
            Text("Currently Selected Contact: \(dataManager.selectedPhoneNumber2)")
            .sheet(isPresented: $isPresentingContacts) {
                // Use CNContactPickerViewController to display contacts
                ContactPickerView(selectedContact: $selectedContact)
            }
            
            if let contact = selectedContact {
                // Accessing the first phone number of the selected contact
                if let phoneNumber = contact.phoneNumbers.first?.value {
                    let phoneNumberString = phoneNumber.stringValue
                    // Use phoneNumberString, which contains the selected contact's phone number
                } else {
                    // No phone number available for the selected contact
                }
            } else {
                // No contact selected
            }

        }
    }
}

struct ContactPickerView: UIViewControllerRepresentable {
    @Binding var selectedContact: CNContact?
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        DispatchQueue.main.async {
            selectedContact = contact
            if let phoneNumber = contact.phoneNumbers.first?.value {
                let phoneNumberString = phoneNumber.stringValue
                print("Selected Phone Number:", phoneNumberString) // Print the selected phone number
                dataManager.selectedPhoneNumber = phoneNumberString
                dataManager.saveSelectedNumbers() // Call the function to save selected numbers
                print("DataManager Selected Phone Number:", dataManager.selectedPhoneNumber) // Print the DataManager's selected phone number after setting it
            } else {
                // No phone number available for the selected contact
            }
        }
    }
    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = CNContactPickerViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(selectedContact: $selectedContact)
    }
    
    class Coordinator: NSObject, CNContactPickerDelegate {
        @Binding var selectedContact: CNContact?
        
        init(selectedContact: Binding<CNContact?>) {
            _selectedContact = selectedContact
        }
        
        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            selectedContact = contact
        }
    }
}
#Preview{
    ContactsView()
}
