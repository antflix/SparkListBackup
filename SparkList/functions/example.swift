import SwiftUI
import ContactsUI

struct ContactsSelectionView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var selectedContacts: [CNContact]? = []
    @State private var isContact1PickerPresented = false

    
    var body: some View {
        VStack {
            Button(action: {
                self.isContact1PickerPresented = true
            }) { HStack {
                Image(systemName: "person.fill.questionmark")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.red, Color.green)
                
                Text("Select Contact 1")
                
            }.padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .sheet(isPresented: $isContact1PickerPresented) {
                
                ContactPickerViewController(selectedContacts: $selectedContacts)
                
                
            }

            if let contacts = selectedContacts, !contacts.isEmpty {
                         List {
                             ForEach(contacts, id: \.self) { contact in
                                 ContactRow(contact: contact) {
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
                 .onAppear {
                     // Retrieve saved contacts from UserDefaults
                     if let savedContacts = dataManager.retrieveSelectedContacts() {
                         self.selectedContacts = savedContacts
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
