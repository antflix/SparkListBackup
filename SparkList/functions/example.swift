// Your code to present contact picker view
import SwiftUI
import ContactsUI
struct ContactPickerView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var selectedContacts: [CNContact] = []
    @State private var retrievedContacts: [CNContact] = []
    @State private var showContactPicker = false

    var body: some View {
        VStack {
            VStack {
                Button("Select Contacts") {
                    showContactPicker = true // Toggle to show the contact picker
                }
                .padding()
            }
            .navigationTitle("Contact Picker Demo")
            .sheet(isPresented: $showContactPicker) {
                ContactPickerViewController(selectedContacts: $dataManager.selectedContacts)
                    .environmentObject(dataManager)
            }
            
            // Display selected contacts
            Text("Selected Contacts:")
                List(selectedContacts, id: \.identifier) { contacts in
                    Text(contacts.givenName + " " + contacts.familyName)
                }
                .padding()
                
                // Button to save contacts to UserDefaults
                Button("Save Contacts") {
                    dataManager.saveSelectedContacts()
                }
                .padding()
                
                // Display retrieved contacts from UserDefaults
                Text("Retrieved Contacts:")
            List(retrievedContacts, id: \.identifier) { contact in
                Text("\(contact.givenName) \(contact.familyName)")
                    .padding()
            }
                    // Button to retrieve contacts from UserDefaults
            Button("Retrieve Contacts")
                {
                    dataManager.retrieveSelectedContacts()
                }
            
                    .padding()
                    
                    // Button to delete contacts from UserDefaults
                    Button("Delete Contacts") {
                        dataManager.deleteSelectedContacts()
                    }
                    .padding()
                }
                
            }
        }
    
//            if let contacts = dataManager.retrieveSelectedContacts() {

//    if let contacts = dataManager.retrieveSelectedContacts()
        //
        //    @State private var isPresentingContactPicker = false
        //
        //    // Function to save selected contacts to UserDefaults
        //    func saveSelectedContacts() {
        //        let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: selectedContacts, requiringSecureCoding: false)
        //        UserDefaults.standard.set(encodedData, forKey: "selectedContactsKey")
        //    }
        //
        //    func retrieveContacts() {
        //        if let savedData = UserDefaults.standard.data(forKey: "selectedContactsKey"),
        //           let decodedContacts = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, CNContact.self], from: savedData) as? [CNContact] {
        //            retrievedContacts = decodedContacts
        //        }
        //    }
        //    // Function to delete contacts from UserDefaults
        //    func deleteContacts() {
        //        UserDefaults.standard.removeObject(forKey: "selectedContactsKey")
        //        retrievedContacts = [] // Clear the retrieved contacts list
        //    }
        //}
        
        // ContactPicker view
        struct ContactPicker: View {
            @Binding var selectedContacts: [CNContact]
            
            var body: some View {
                NavigationView {
                    List {
                        ForEach(0..<10) { index in // Replace this with your actual contact picker logic
                            Text("Contact \(index)")
                                .onTapGesture {
                                    let contact = CNContact() // Replace this with logic to fetch the actual contact
                                    selectedContacts.append(contact)
                                }
                        }
                    }
                    .navigationTitle("Select Contacts")
                    .navigationBarItems(trailing:
                                            Button("Done") {
                        // Dismiss the view here
                    }
                    )
                }
            }
        }
    



//
////import SwiftUI
////
////struct ModeToggleButton: View {
////    @Environment(\.colorScheme) var colorScheme // Get the current color scheme
////    @State private var isDarkMode = false
////
////
////    var body: some View {
////        let appearanceMode = colorScheme == .dark ? "Dark" : "Light" // Check the current appearance mode
////
////        AlarmSettingView()
////        Divider()
////            .background(Color.blue)
////        HStack {
////                   Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
////                       .foregroundColor(isDarkMode ? .blue : .yellow) // Colors for sun and moon
////                       .font(.title)
////                       .padding(.leading, isDarkMode ? 10 : 0)
////                   
////                   Spacer()
////                   
////            Toggle("", isOn: $isDarkMode)
////                .toggleStyle(toggle())
////                          .onChange(of: isDarkMode) { _ in
////                              withAnimation {
////                                  // Optionally perform any additional actions when the mode changes
////                              }
////                          }
////                   
////                   Spacer()
////                   
////                   Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
////                       .foregroundColor(isDarkMode ? .yellow : .blue) // Colors for sun and moon
////                       .font(.title)
////                       .padding(.trailing, isDarkMode ? 0 : 10)
////               }
////        Spacer()
////        Button(action: {
////            // Toggle between light and dark mode
////            dataManager.clearAllSMSData()
////        }) {
////            Text("Clear SMS Data")
////                .padding()
////                .background(Color.red)
////                .foregroundColor(.white)
////                .cornerRadius(8)
////        }
////        
////        
////       Spacer()
////        
////    }
////    
////}
////struct CustomSliderToggleStyle: ToggleStyle {
////    func makeBody(configuration: Configuration) -> some View {
////        VStack {
////            ZStack {
////                RoundedRectangle(cornerRadius: 10)
////                    .fill(Color.gray.opacity(0.5)) // Customize slider background color
////                
////                RoundedRectangle(cornerRadius: 10)
////                    .fill(Color.white) // Customize slider color
////                    .offset(x: configuration.isOn ? 100 : -100) // Adjust the sliding position
////                
////                // Customize the size of the slider
////                Circle()
////                    
////            }
////            .frame(width: 50, height: 30) // Adjust the overall size of the slider
////            .onTapGesture { configuration.isOn.toggle() }
////            
////            configuration.label
////        }
////    }
////}
////
////struct SymbolInCircleSliderToggleStyle: ToggleStyle {
////    let isDarkMode: Bool
////    
////    func makeBody(configuration: Configuration) -> some View {
////        HStack {
////            ZStack(alignment: isDarkMode ? .trailing : .leading) {
////                RoundedRectangle(cornerRadius: 10)
////                    .fill(Color.gray.opacity(0.5))
////                
////                RoundedRectangle(cornerRadius: 10)
////                    .fill(Color.white)
////                    .offset(x: configuration.isOn ? 25 : -25)
////                
////                Circle()
////                    .foregroundColor(.white)
////                    .frame(width: 30, height: 30)
////                    .shadow(radius: 3)
////                    .offset(x: configuration.isOn ? 25 : -25)
////                    .overlay(
////                        Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
////                            .foregroundColor(isDarkMode ? .blue : .yellow)
////                            .font(.title2)
////                            .offset(x: 0) // Default position for the circle
////                    )
////            }
////            .frame(width: 60, height: 30)
////            .onTapGesture { configuration.isOn.toggle() }
////            
////            configuration.label
////        }
////    }
////}
////struct SunMoonToggleStyle: ToggleStyle {
////    func makeBody(configuration: Configuration) -> some View {
////        HStack {
////            configuration.label // Display the label (EmptyView) if needed
////            
////            ZStack {
////                
////                Capsule()
////                    .frame(width: 60, height: 30)
////                    .foregroundStyle(Color.blue)// Customize the pill shape
////                
////                Image(systemName: configuration.isOn ? "moon.stars" : "sun.max")
////                    .foregroundStyle(configuration.isOn ? Color.yellow : Color.black)
////                    .offset(x: configuration.isOn ? 15 : -15, y: 0) // Position sun or moon inside the pill
////            }
////            .background(configuration.isOn ? Color.blue : Color.blue) // Customize the background color based on the toggle state
////            .cornerRadius(15) // Adjust corner radius for pill shape
////            .onTapGesture { configuration.isOn.toggle() } // Toggle state on tap
////        }
////    }
////}
////#Preview {
////    ModeToggleButton()
////}
////
////
////
////  example.swift
////  SparkList
////
////  Created by User on 11/30/23.
////
//import SwiftUI
//// First ContentView with a list and buttons
//@available(iOS 17.0, *)
//struct FirstContentView: View {
//    @State private var showModal = false
//    @State private var showAlert = false
//    @State private var navigationActive = false
//    @State private var value2 = 0
//    @State private var animationIsActive = false
//    @State private var animationsRunning = false
//    private var buttonTitle: String {
//    @State var isPopoverPresented = false
//
//         return animationIsActive ? "Stop animations" : "Start animations"
//     }
//    var body: some View {
//        NavigationStack {
//            
//            
//            VStack {
//           
//                Image("light")     
//                    .rotationEffect(Angle(degrees: 180))
//                    .symbolRenderingMode(.multicolor)
//                    .foregroundStyle(Color.yellow, Color.orange, Color.white)
//
//                    .symbolEffect(.variableColor.reversing.iterative.hideInactiveLayers, options: .default, value: animationsRunning)
//                       
//            }        .font(.largeTitle)
//            Button("Start Animations") {
//                       withAnimation {
//                           animationsRunning.toggle()
//                       }
//            }
//                    
//            }
//
//                    
//                    
////              .variableColor.iterative.hideInactiveLayers.reversing      .variableColor
////                    .iterative
////                    .hideInactiveLayers
////                    .reversing
//////                    .resizable()
////                    .font(.system(size: 20, weight: .ultraLight))
////                    .foregroundColor(.yellow) // Set initial color
////                    .colorMultiply(.orange) // Set secondary color
////                .animation(Animation.linear(duration:2.0).repeatForever()) // Apply color animation
//            }
//        }
//    
//
////
////// Second ContentView with different alerts and modals
////struct SecondContentView: View {
////    @State private var showActionSheet = false
////    @State private var showFullScreenCover = false
////    
////    var body: some View {
////        ZStack {
////            // Header background
////            Color.blue
////                .frame(height: 100)
////            
////            // Lightbulb
////            VStack(spacing: 0) {
////                // Lightbulb body
////                Capsule()
////                    .fill(Color.white)
////                    .frame(width: 30, height: 50)
////                
////                // Lightbulb filament
////                Path { path in
////                    path.move(to: CGPoint(x: 15, y: 50))
////                    path.addQuadCurve(to: CGPoint(x: 15, y: 60), control: CGPoint(x: 5, y: 55))
////                    path.addQuadCurve(to: CGPoint(x: 15, y: 50), control: CGPoint(x: 25, y: 55))
////                }
////                .stroke(Color.orange, lineWidth: 2)
////            }
////            .frame(width: 30, height: 60)
////            .offset(y: 20) // Offset the lightbulb down from the header
////            
////            VStack {
////                
////                Button("Show Action Sheet") {
////                    showActionSheet = true
////                }
////                .padding()
////                .background(Color.purple)
////                .foregroundColor(Color.white)
////                .cornerRadius(8)
////                .actionSheet(isPresented: $showActionSheet) {
////                    ActionSheet(title: Text("Action Sheet"), message: Text("Choose an action"), buttons: [
////                        .default(Text("Action 1")),
////                        .default(Text("Action 2")),
////                        .cancel()
////                    ])
////                }
////                
////                Button("Show Full Screen Cover") {
////                    showFullScreenCover = true
////                }
////                .padding()
////                .background(Color.yellow)
////                .foregroundColor(Color.black)
////                .cornerRadius(8)
////                .fullScreenCover(isPresented: $showFullScreenCover) {
////                    FullScreenCoverView()
////                }
////                
////                NavigationLink("Go to First View", destination: FirstContentView())
////                    .padding()
////                    .background(Color.red)
////                    .foregroundColor(Color.white)
////                    .cornerRadius(8)
////            }
////        }
////        
////        
////    }
////}
//////        .background(Color.blue)
//////        .foregroundColor(.white)
//////        .font(.headline)
//////        
//////        }
//////    }
////
////
////// Third ContentView with links navigating to the first two views
////struct ThirdContentView: View {
////    var body: some View {
////        VStack {
////            NavigationLink("Go to First View", destination: FirstContentView())
////                .padding()
////                .background(Color.blue)
////                .foregroundColor(Color.white)
////                .cornerRadius(8)
////            
////            NavigationLink("Go to Second View", destination: SecondContentView())
////                .padding()
////                .background(Color.green)
////                .foregroundColor(Color.white)
////                .cornerRadius(8)
////        }
////        .navigationTitle("Third View")
////    }
////}
////
////// ModalView
////struct ModalView: View {
////    var body: some View {
////        Text("Modal View")
////            .padding()
////            .background(Color.gray)
////            .foregroundColor(Color.white)
////            .cornerRadius(8)
////    }
////}
////
////// FullScreenCoverView
////struct FullScreenCoverView: View {
////    var body: some View {
////        Text("Full Screen Cover View")
////            .padding()
////            .background(Color.pink)
////            .foregroundColor(Color.white)
////            .cornerRadius(8)
////    }
////}
//
//// Preview
//@available(iOS 17.0, *)
//struct FirstContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        FirstContentView()
////        SecondContentView()
////        ThirdContentView()
//
//    }
//}
////////import SwiftUI
////////
////////struct JobsView: View {
////////
////////  @State private var searchText = ""
////////  @State private var jobs = [[String]]()
////////  @EnvironmentObject var dataManager: DataManager
////////  @State private var selectedRow: Int? = nil
////////  @Environment(\.colorScheme) var colorScheme
////////  @State private var showingPopover: [Bool] = []  // Add state for showing popover
////////
////////  private let apiURL = "https://app.antflix.net/api/joblist"
////////
////////  var body: some View {
////////    VStack {
////////      HStack {
////////        Text("Job Name").font(Font.custom("Quicksand", size: 25).bold())
////////          .frame(maxWidth: .infinity * 0.90, alignment: .leading)
////////        Text("Job Date").font(Font.custom("Quicksand", size: 25).bold())
////////          .frame(maxWidth: .infinity * 0.15, alignment: .trailing)
////////      }
////////      .padding()
////////      .background(Color.blue)
////////      .foregroundColor(.white)
////////      .font(.headline)
////////      ScrollView {
////////        ForEach(0..<jobs.count, id: \.self) { index in
////////          let job = jobs[index]
////////          HStack {
////////            Text(job[1])
////////              .frame(maxWidth: .infinity * 0.90, alignment: .leading)
////////              .lineLimit(1)
////////            Text(job[2])
////////            Spacer()
////////            Button(action: {
////////              // Toggle the popover state for this particular row
////////              showingPopover[index].toggle()
////////            }) {
////////              Image(systemName: "info.circle")
////////                .foregroundColor(.blue)
////////            }
////////            .popover(isPresented: $showingPopover[index]) {
////////              VStack {
////////                // Define your popover content here
////////                Spacer()
////////                Text("Job Name-").font(.largeTitle).underline(Bool(true))
////////                Text("\(job[1])").foregroundStyle(Color.blue).font(.title)
////////
////////                Spacer()
////////
////////                Text("Job #-").font(.largeTitle).underline(Bool(true))
////////                Text("\(job[0])").foregroundStyle(Color.blue).font(.title)
////////                Spacer()
////////
////////                Text("Date Created").font(.largeTitle).underline(Bool(true))
////////                Text("\(job[2])").foregroundStyle(Color.blue).font(.title)
////////                Spacer()
////////
////////              }
////////            }
////////          }
////////          // Rest of your view code...
////////
////////          .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
////////          .font(colorScheme == .dark ? .headline : .headline)
////////          //                        .font(.system(size: 14))
////////          .padding(5)
////////          .frame(maxWidth: .infinity * 0.85, alignment: .leading).background(
////////            selectedRow == jobs.firstIndex(of: job) ? Color.blue.opacity(0.3) : Color.clear
////////          )
////////          .onTapGesture {
////////            selectedRow = jobs.firstIndex(of: job)
////////            let selectedJobID = job[0]
////////            dataManager.selectedJobID = selectedJobID
////////            // Navigate to EmployeeView here
////////          }
////////
////////        }
////////      }
////////      .background(
////////        Color(#colorLiteral(red: 0.2095631361, green: 0.1996625662, blue: 0.2041486502, alpha: 1))
////////      )
////////      .foregroundColor(Color.black)
////////      .onAppear {
////////        // Initialize the showingPopover array based on the number of jobs
////////        fetchData()
////////        showingPopover = Array(repeating: false, count: jobs.count)
////////
////////      }
////////      Spacer()
////////      SearchBar(text: $searchText)
////////      //                NavigationLink(destination: EmployeeView()) {
////////      //                    Text("Next")
////////      //                }
////////    }
////////
////////  }
////////
////////  // Function to fetch data from API
////////  // Function to fetch data from API
////////  private func fetchData() {
////////    if let cachedJobs = UserDefaults.standard.array(forKey: "CachedJobs") as? [[String]] {
////////      if !isDataStale() {
////////        self.jobs = cachedJobs
////////        return
////////      }
////////    }
////////
////////    guard let url = URL(string: apiURL) else { return }
////////
////////    URLSession.shared.dataTask(with: url) { data, _, error in
////////      if let data = data {
////////        if let decodedData = try? JSONSerialization.jsonObject(with: data, options: [])
////////          as? [[String]]
////////        {
////////          DispatchQueue.main.async {
////////            self.jobs = decodedData  // Update jobs array with fetched data
////////            UserDefaults.standard.set(decodedData, forKey: "CachedJobs")
////////            UserDefaults.standard.set(Date(), forKey: "LastRefreshDate")
////////          }
////////        }
////////      } else {
////////        print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
////////      }
////////    }.resume()
////////  }
////////
////////  // Function to determine background color based on color scheme
////////  // Function to determine background color based on color scheme
////////  private func backgroundBasedOnColorScheme() -> Color {
////////    if colorScheme == .dark {
////////      return (Color(white: 3.0, opacity: 0.1))
////////    } else {
////////      return Color.white  // Change this to your desired light mode color
////////    }
////////  }
////////
////////  private func isDataStale() -> Bool {
////////    if let lastRefreshDate = UserDefaults.standard.object(forKey: "LastRefreshDate") as? Date {
////////      let currentDate = Date()
////////      let calendar = Calendar.current
////////      if let difference = calendar.dateComponents([.hour], from: lastRefreshDate, to: currentDate)
////////        .hour, difference >= 24
////////      {
////////        return true
////////      }
////////    }
////////    return false
////////  }
////////}
////////// Custom Search Bar
////////struct SearchBar: View {
////////  @Binding var text: String
////////
////////  var body: some View {
////////    VStack {
////////      TextField("Search", text: $text).font(Font.custom("Quicksand", size: 25).bold())
////////        .textFieldStyle(DefaultTextFieldStyle())
////////
////////        .background(RoundedRectangle(cornerRadius: 15).stroke(Color.blue, lineWidth: 1))
////////        .background(
////////          Color(
////////            #colorLiteral(red: 0.2370054126, green: 0.2370054126, blue: 0.2370054126, alpha: 1))
////////        )
////////
////////        .foregroundColor(.white)
////////      Text("")
////////
////////    }
////////  }
////////}
////////
////////struct JobsView_Previews: PreviewProvider {
////////  static var previews: some View {
////////    JobsView()
////////      .environmentObject(DataManager())
////////  }
////////}
//////
////////
////////.popover(isPresented: $showingPopover[index]) {
////////    // Define your popover content here
////////                      VStack{
////////                          // Define your popover content here
////////                          Spacer()
////////                          Text("Job Name-").font(.largeTitle).underline(Bool(true))
////////                          Text("\(job[1])").foregroundStyle(Color.blue).font(.title)
////////                          
////////                          Spacer()
////////                          
////////                          Text("Job #-").font(.largeTitle).underline(Bool(true))
////////                          Text("\(job[0])").foregroundStyle(Color.blue).font(.title)
////////                          Spacer()
////////                          
////////                          Text("Date Created").font(.largeTitle).underline(Bool(true))
////////                          Text("\(job[2])").foregroundStyle(Color.blue).font(.title)
////////                          Spacer()
////////                          
////////                      }
////////                  }
