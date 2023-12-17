import SwiftUI
import ContactsUI

struct ContactPickerViewController: UIViewControllerRepresentable {
    @EnvironmentObject var dataManager: DataManager
    @Binding var selectedContactName: String
    @Binding var selectedContactPhoneNumber: String
    @Binding var selectedContactName2: String // Additional binding for second contact name
    @Binding var selectedContactPhoneNumber2: String // Additional binding for second contact phone number

    func makeUIViewController(context: Context) -> UIViewController {
          let picker = CNContactPickerViewController()
          picker.delegate = context.coordinator

          let navigationController = UINavigationController(rootViewController: picker)
          navigationController.navigationBar.tintColor = UIColor.systemBlue
          navigationController.view.backgroundColor = UIColor.white

          return navigationController
      }


    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
          // Implement update logic if needed
      }



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
