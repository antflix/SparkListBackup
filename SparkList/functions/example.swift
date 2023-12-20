import SwiftUI
import ContactsUI

struct ContactView: View {
    @StateObject var dataManager = DataManager()
    @State private var selectedContacts: [CNContact] = []
    @State private var retrievedContacts: [CNContact] = []

    var body: some View {
        NavigationView {
            VStack {
                Button("Select Contacts") {
                    showContactPicker = true
                }
                .padding()

                List {
                    ForEach(retrievedContacts.indices, id: \.self) { index in
                        let contact = retrievedContacts[index]
                        VStack(alignment: .leading) {
                            Text("\(contact.givenName) \(contact.familyName)")
                            Text(contact.phoneNumbers.first?.value.stringValue ?? "No phone number")
                                .foregroundColor(.gray)
                        }
                        .contextMenu {
                            Button("Delete") {
                                deleteContact(at: index)
                            }
                        }
                    }
                }

                Spacer()
            }
            .navigationTitle("Contacts")
            .sheet(isPresented: $showContactPicker) {
                ContactPickerViewController(selectedContacts: Binding($selectedContacts))
                    .environmentObject(dataManager)
            }
            .onAppear {
                if let contacts = dataManager.retrieveSelectedContacts() {
                    retrievedContacts = contacts
                }
            }
        }
    }

    @State private var showContactPicker = false

    func deleteContact(at index: Int) {
        retrievedContacts.remove(at: index)
        dataManager.deleteSelectedContacts()
    }
}
