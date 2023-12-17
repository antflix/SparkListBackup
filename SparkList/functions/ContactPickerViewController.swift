import SwiftUI
import ContactsUI

struct ContactPickerViewController: UIViewControllerRepresentable {
    @EnvironmentObject var dataManager: DataManager // Access the DataManager

    @Binding var selectedContactName: String
    @Binding var selectedContactPhoneNumber: String
    @Binding var selectedContactName2: String // Additional binding for second contact name
    @Binding var selectedContactPhoneNumber2: String // Additional binding for second contact phone number

 
    func makeUIViewController(context: Context) -> CNContactPickerViewController {
           let picker = CNContactPickerViewController()
           picker.delegate = context.coordinator

           // Modify the appearance of the contact picker
           picker.navigationBar.tintColor = UIColor.systemBlue // Change navigation bar tint color
           picker.view.backgroundColor = UIColor.white // Set background color

           return picker
       }

    func updateUIViewController(_ uiViewController: CNContactPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
         Coordinator(parent: self, dataManager: dataManager)
     }

     class Coordinator: NSObject, CNContactPickerDelegate {
         let parent: ContactPickerViewController
         var dataManager: DataManager

         init(parent: ContactPickerViewController, dataManager: DataManager) {
             self.parent = parent
             self.dataManager = dataManager
         }

           func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
               let fullName = CNContactFormatter.string(from: contact, style: .fullName) ?? ""
               let phoneNumbers = contact.phoneNumbers.first?.value.stringValue ?? ""

               if self.dataManager.selectedContactName.isEmpty {
                   self.dataManager.selectedContactName = fullName
                   self.dataManager.selectedContactPhoneNumber = phoneNumbers
               } else {
                   self.dataManager.selectedContactName2 = fullName
                   self.dataManager.selectedContactPhoneNumber2 = phoneNumbers
               }
           }
       }
   }
