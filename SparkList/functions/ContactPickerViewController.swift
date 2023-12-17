func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
       if dataManager.selectedContact1 == nil {
           dataManager.selectedContact1 = contact
       } else {
           dataManager.selectedContact2 = contact
       }
   } func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
       if dataManager.selectedContact1 == nil {
           dataManager.selectedContact1 = contact
       } else {
           dataManager.selectedContact2 = contact
       }
   }
