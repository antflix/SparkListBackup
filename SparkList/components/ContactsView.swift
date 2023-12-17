import SwiftUI
import ContactsUI
struct ContactsView: View {
    @EnvironmentObject var dataManager: DataManager // Access the DataManager

    @State private var isContact1PickerPresented = false
    @State private var isContact2PickerPresented = false

    var body: some View {
        VStack {
            if dataManager.selectedContactName.isEmpty || dataManager.selectedContactName2.isEmpty {
                HStack{
                    Text("Who do you turn in tie to? ").font(.title2).padding()}.background(Color("Color 1"))
                Spacer()
                Button(action: {
                    self.isContact1PickerPresented = true
                }) {
                    Text("Select Contact 1")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .sheet(isPresented: $isContact1PickerPresented) {
                    NavigationView {
                        ContactPickerViewController()
                            .environmentObject(dataManager)
                            .navigationBarItems(trailing: Button("Close") {
                                self.isContact1PickerPresented = false
                            })
                            .navigationBarTitle("Select Contact 1")
                    }
                }
                .padding()

                if !dataManager.selectedContactName.isEmpty {
                    Button(action: {
                        self.isContact2PickerPresented = true
                    }) {
                        Text("Select Contact 2")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .sheet(isPresented: $isContact2PickerPresented) {
                        NavigationView {
                            ContactPickerViewController()
                                .environmentObject(dataManager)
                                .navigationBarItems(trailing: Button("Close") {
                                    self.isContact2PickerPresented = false
                                })
                                .navigationBarTitle("Select Contact 2")
                        }
                    }
                    .padding()
                }
            }

            if !dataManager.selectedContactName.isEmpty {
                Text("Selected Contact 1: \(dataManager.selectedContactName)")
                Text("Phone Number 1: \(dataManager.selectedContactPhoneNumber)").padding()

                if !dataManager.selectedContactName2.isEmpty {
                    Text("Selected Contact 2: \(dataManager.selectedContactName2)")
                    Text("Phone Number 2: \(dataManager.selectedContactPhoneNumber2)")
                }
            }
        }
        .padding()
    }
}
#Preview{
    ContactsView()
        .environmentObject(DataManager())

}
