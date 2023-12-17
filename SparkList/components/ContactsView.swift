import ContactsUI
import SwiftUI
@available(iOS 17.0, *)
struct ContactsView: View {
    @EnvironmentObject var dataManager: DataManager // Access the DataManager
    @State private var symbolAnimation = false

    @State private var isContact1PickerPresented = false
    @State private var isContact2PickerPresented = false

    var body: some View {
        VStack {
            HStack {
                Text("Time Contacts?").font(Font.custom("Quicksand", size: 26).bold())
                    .frame(maxWidth: .infinity * 0.90, alignment: .center)

            }.padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .font(.headline)
            Spacer()

            
            // 1 is empty
            // 2 is empty
            if dataManager.selectedContactName.isEmpty && dataManager.selectedContactName2.isEmpty {
                Text("No Contacts Selected. Please choose 1 or 2 contacts to send your time to.")
                    .font(Font.custom("Quicksand", size: 20).bold())
                    .frame(maxWidth: .infinity * 0.90, alignment: .center)
                    .padding()
                Image(systemName: "person.crop.circle.badge.xmark")
                    .aspectRatio(contentMode: .fit)
                    .padding(/*@START_MENU_TOKEN@*/ .all/*@END_MENU_TOKEN@*/)
                    .font(Font.custom("Quicksand", size: 86).bold())
                    .symbolRenderingMode(.palette)
                    .onAppear {
                        symbolAnimation.toggle()
                    }
                    .foregroundStyle(Color.red, Color.yellow)

                    .symbolEffect(.variableColor.reversing.cumulative, options: .repeat(100).speed(1), value:
                        symbolAnimation)
                Spacer()

                //add contact 1
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
                
                //add contact2
                Button(action: {
                    self.isContact2PickerPresented = true
                }) { HStack {
                    Image(systemName: "person.fill.questionmark")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.red, Color.green)

                    Text("Select Contact 2")

                }.padding()
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
            //  1 is not empty
            // 2 is empty
            if !dataManager.selectedContactName.isEmpty && dataManager.selectedContactName2.isEmpty {
//                Text("Selected Contact 1: \(dataManager.selectedContactName)")
//                                   Text("Phone Number 1: \(dataManager.selectedContactPhoneNumber)").padding()
                
                //  1 contact card
                if let contact1 = dataManager.selectedContact1 {
                    ContactCardView(contact: contact1)
                }
                //   1 clear button
                Button("Clear Contact 1") {
                    dataManager.clearFirstContact()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(8)
                .padding()

                //2 add contact button
                Button(action: {
                    self.isContact2PickerPresented = true
                }) { HStack {
                    Image(systemName: "person.fill.questionmark")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.red, Color.green)

                    Text("Select Contact 2")

                }.padding()
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
            
            // 1 is empty
            // 2 is not empty
            if dataManager.selectedContactName.isEmpty && !dataManager.selectedContactName2.isEmpty {
                //1 add button
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
//                Text("Selected Contact 2: \(dataManager.selectedContactName2)")
//                      Text("Phone Number 2: \(dataManager.selectedContactPhoneNumber2)")
                //2 contact card
                if let contact2 = dataManager.selectedContact2 {
                    ContactCardView(contact: contact2)
                }
                //2 clear button
                Button("Clear Contact 2") {
                    dataManager.clearSecondContact()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(8)
                .padding()
            }
            //1 is not empty
            //2 is not empty/
            if !dataManager.selectedContactName.isEmpty && !dataManager.selectedContactName2.isEmpty {
//                Text("Selected Contact 1: \(dataManager.selectedContactName)")
//                Text("Phone Number 1: \(dataManager.selectedContactPhoneNumber)").padding()
                //1 contact card
                if let contact1 = dataManager.selectedContact1 {
                    ContactCardView(contact: contact1)
                }
                //1  clear
                Button("Clear Contact 1") {
                    dataManager.clearFirstContact()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(8)
                .padding()
//                Text("Selected Contact 2: \(dataManager.selectedContactName2)")
//                Text("Phone Number 2: \(dataManager.selectedContactPhoneNumber2)")
                //2 contact card
                if let contact2 = dataManager.selectedContact2 {
                    ContactCardView(contact: contact2)
                }
                //2 clear
                Button("Clear Contact 2") {
                    dataManager.clearSecondContact()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(8)
                .padding()
            }
            //   if !dataManager.selectedContactName.isEmpty {
//                    Text("Selected Contact 1: \(dataManager.selectedContactName)")
//                    Text("Phone Number 1: \(dataManager.selectedContactPhoneNumber)").padding()
//                    Button("Clear Contact 1") {
//                        dataManager.clearFirstContact()
//                    }
//                    .padding()
//                    .foregroundColor(.white)
//                    .background(Color.red)
//                    .cornerRadius(8)
//                    .padding()
//                }
//                if !dataManager.selectedContactName2.isEmpty {
//                    Text("Selected Contact 2: \(dataManager.selectedContactName2)")
//                    Text("Phone Number 2: \(dataManager.selectedContactPhoneNumber2)")
//                    Button("Clear Contact 1") {
//                        dataManager.clearSecondContact()
//                    }
//                    .padding()
//                    .foregroundColor(.white)
//                    .background(Color.red)
//                    .cornerRadius(8)
//                    .padding()
//                } else {
//                    Text("No Contacts Selected. Please Choose someone to send your time to.")
//                        .padding()
//                    Image(systemName: "person.crop.circle.badge.xmark")
//                        .aspectRatio(contentMode: .fit)
//                        .padding(/*@START_MENU_TOKEN@*/ .all/*@END_MENU_TOKEN@*/)
//                        .font(Font.custom("Quicksand", size: 86).bold())
//                        .symbolRenderingMode(.palette)
//                        .onAppear {
//                            symbolAnimation.toggle()
//                        }
//                        .foregroundStyle(Color.red, Color.yellow)
//
//                        .symbolEffect(.variableColor.reversing.cumulative, options: .repeat(100).speed(1), value:
//                            symbolAnimation)
//
//
//                Spacer()
//                Button(action: {
//                    self.isContact1PickerPresented = true
//                }) { HStack {
//                    Image(systemName: "person.fill.questionmark")
//                        .symbolRenderingMode(.palette)
//                        .foregroundStyle(Color.red, Color.green)
//
//                    Text("Select Contact 1")
//
//                }.padding()
//                    .foregroundColor(.white)
//                    .background(Color.blue)
//                    .cornerRadius(8)
//                }
//                .sheet(isPresented: $isContact1PickerPresented) {
//                    NavigationView {
//                        ContactPickerViewController()
//                            .environmentObject(dataManager)
//                            .navigationBarItems(trailing: Button("Close") {
//                                self.isContact1PickerPresented = false
//                            })
//                            .navigationBarTitle("Select Contact 1")
//                    }
//                }
//                .padding()
//
//                    if !dataManager.selectedContactName.isEmpty {
//
//                    }
//            }
//
        }
        .background(EllipticalGradient(colors: [Color("Color 7"), Color("Color 8")], center: .top, startRadiusFraction: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, endRadiusFraction: 0.8))
    }
}

struct ProfileInfoView: View {
    var contact: CNContact // Directly using CNContact from DataManager

    var body: some View {
        VStack {
            // Display detailed contact information
            Text("\(contact.givenName) \(contact.familyName)")
                .font(.title)
                .foregroundColor(.black)
            
            // Display additional contact details...
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
}

struct ContactCardView: View {
    var contact: CNContact // Assuming you have a CNContact object passed to this view

    var body: some View {
        VStack {
            if let imageData = contact.thumbnailImageData, let image = UIImage(data: imageData) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .padding()
            }

            Text("\(contact.givenName) \(contact.familyName)")
                .font(.title)
                .foregroundColor(.black)

            if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
                Text("Phone Number: \(phoneNumber)")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.bottom)
            }

            // Add more contact information if needed
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
}

@available(iOS 17.0, *)
struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView()
            .environmentObject(DataManager())
    }
}
