import SwiftUI
import ContactsUI
@available(iOS 17.0, *)
struct ContactsView: View {
    @EnvironmentObject var dataManager: DataManager // Access the DataManager
    @State private var symbolAnimation = false

    @State private var isContact1PickerPresented = false
    @State private var isContact2PickerPresented = false

    var body: some View {
        VStack {
            if dataManager.selectedContactName.isEmpty || dataManager.selectedContactName2.isEmpty {
                HStack {
                    Text("Who do you turn time into?").font(Font.custom("Quicksand", size: 26).bold())
                        .frame(maxWidth: .infinity * 0.90, alignment: .center)
                    
                }.padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .font(.headline)
                if !dataManager.selectedContactName.isEmpty {
                    Text("Selected Contact 1: \(dataManager.selectedContactName)")
                    Text("Phone Number 1: \(dataManager.selectedContactPhoneNumber)").padding()
                    Button("Clear Contact 1") {
                                       dataManager.clearFirstContact()
                                   }
                                   .padding()
                                   .foregroundColor(.white)
                                   .background(Color.red)
                                   .cornerRadius(8)
                                   .padding()

                    if !dataManager.selectedContactName2.isEmpty {
                        Text("Selected Contact 2: \(dataManager.selectedContactName2)")
                        Text("Phone Number 2: \(dataManager.selectedContactPhoneNumber2)")
                        
                      
                           
                    }
                    
                }
                else {
                    Text("No Contacts Selected. Please Choose someone to send your time to.")
                        .padding()
                    Image(systemName: "person.crop.circle.badge.xmark")
                        .aspectRatio(contentMode: .fit)
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .font(Font.custom("Quicksand", size: 86).bold())
                        .symbolRenderingMode(.palette)
                        .onAppear(){
                            symbolAnimation.toggle()
                        }
                        .foregroundStyle(Color.red, Color.yellow)
                        
                        .symbolEffect(.variableColor.reversing.cumulative, options: .repeat(100).speed(1), value:
                                        symbolAnimation)

                        
                        
                }
                
                Spacer()
                Button(action: {
                    self.isContact1PickerPresented = true
                }) {HStack{
                    Image(systemName: "person.fill.questionmark")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.red, Color.green)

                    Text("Select Contact 1")
                     
                }   .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)}
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
            if !dataManager.selectedContactName.isEmpty || !dataManager.selectedContactName2.isEmpty {
                Text("")
            }

 
        }
        .background(EllipticalGradient(colors:[Color("Color 7"), Color("Color 8")], center: .top, startRadiusFraction: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, endRadiusFraction: 0.8))
        
    }
    func ClearContact1() {
            dataManager.selectedContactPhoneNumber = ""
        dataManager.selectedContactName = ""
        }
}
@available(iOS 17.0, *)
struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView()
            .environmentObject(DataManager())
    }
}
