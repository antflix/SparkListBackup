import SwiftUI
import ContactsUI

struct ContactsSelectionView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var selectedContacts: [CNContact]? = []

    var body: some View {
        VStack {
            Button("Select Contacts") {
                // Present the contact picker
                // Implement logic to present `ContactPickerViewController`
            }
            .padding()

            if let contacts = selectedContacts, !contacts.isEmpty {
                List {
                    ForEach(contacts, id: \.self) { contact in
                        ContactRow(contact: contact) {
                            // Implement deletion logic for each contact
                            if let index = selectedContacts?.firstIndex(of: contact) {
                                selectedContacts?.remove(at: index)
                                dataManager.saveSelectedContacts()
                            }
                        }
                    }
                }
            } else {
                Text("No contacts selected")
            }
        }
    }
}

struct ContactRow: View {
    let contact: CNContact
    let onDelete: () -> Void

    var body: some View {
        HStack {
            Text("\(contact.givenName) \(contact.familyName)")
            Spacer()
            Button(action: onDelete) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
    }
}
