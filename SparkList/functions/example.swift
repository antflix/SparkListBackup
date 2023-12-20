import SwiftUI
import ContactsUI
struct ContactView: View {
    @EnvironmentObject var dataManager: DataManager
    @Binding var retrievedContacts: [CNContact]
    @State private var selectedContacts: [CNContact] = []
    @State private var showContactPicker = false

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
                ContactPickerViewController(selectedContacts: $dataManager.selectedContacts)
                    .environmentObject(dataManager)
                    .onDisappear {
                        retrievedContacts = dataManager.retrieveSelectedContacts() ?? []
                    }
            }
            .onAppear {
                retrievedContacts = dataManager.retrieveSelectedContacts() ?? []
            }
        }
    }

    func deleteContact(at index: Int) {
        retrievedContacts.remove(at: index)
        dataManager.deleteSelectedContacts()
    }
}
