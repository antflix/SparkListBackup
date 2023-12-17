import SwiftUI
import ContactsUI
struct ContactsView: View {
    @EnvironmentObject var dataManager: DataManager // Access the DataManager

    @State private var isContact1PickerPresented = false
    @State private var isContact2PickerPresented = false

    var body: some View {
        VStack {
            if dataManager.selectedContactName.isEmpty || dataManager.selectedContactName2.isEmpty {
                Button(action: {
                    self.isContact1PickerPresented = true
                }) {
                    Text("Select Contact 1")
                }
                .sheet(isPresented: $isContact1PickerPresented) {
                    ContactPickerViewController()
                        .environmentObject(dataManager)
                }
            }

            if !dataManager.selectedContactName.isEmpty {
                Text("Selected Contact 1: \(dataManager.selectedContactName)")
                Text("Phone Number 1: \(dataManager.selectedContactPhoneNumber)")

                if dataManager.selectedContactName2.isEmpty {
                    Button(action: {
                        self.isContact2PickerPresented = true
                    }) {
                        Text("Select Contact 2")
                    }
                    .sheet(isPresented: $isContact2PickerPresented) {
                        ContactPickerViewController()
                            .environmentObject(dataManager)
                    }
                }
            }

            if !dataManager.selectedContactName2.isEmpty {
                Text("Selected Contact 2: \(dataManager.selectedContactName2)")
                Text("Phone Number 2: \(dataManager.selectedContactPhoneNumber2)")
            }
        }
        .padding()
    }
}
