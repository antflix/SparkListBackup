// Created a new SwiftUI file for a modified version of the EmployeesView
import SwiftUI
@available(iOS 17.0, *)
struct EmployeeView: View {
    @EnvironmentObject var dataManager: DataManager // Access DataManager passed via environmentObject
    @State private var selectedEmployees: [String] = [] // Store selected employee names
    @State private var hoursWorked: String = "" // Store the amount of hours worked
    @State private var showInstructions = true // Track
    @State private var showPreView = false // State to control navigation
    @State private var isNavigatingToEmployeesView = false
    @State private var selectedHours = 0
    @Environment(\.colorScheme) var colorScheme
    @State private var showingPopover = false // Create a state variable to control popover visibility
    @State private var settingsPopover = false // Create a state variable to control popover visibility
    
    // Add a computed property to check if selections are made
    var isSelectionComplete: Bool {
        return !selectedEmployees.isEmpty && selectedHours != 0
    }
    var isEmployeeComplete: Bool {
        return !selectedEmployees.isEmpty
    }
    
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Employee Hours").font(Font.custom("Quicksand", size: 30).bold())
                        .frame( alignment: .center)
                    
                    Text("Same crew, Same Hours").font(Font.custom("Quicksand", size: 12).bold())
                        .frame(maxWidth: .infinity * 0.90, alignment: .center)
                        .foregroundStyle(Color.black)
                }
                
                Button(action: {
                    // Toggle the popover state for this particular row
                    showingPopover.toggle()
                }) {
                    Image(systemName: "questionmark.circle.fill")
                        .foregroundColor(.white)
                }
                .buttonStyle(PlainButtonStyle())
                .popover(isPresented: $showingPopover) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Instructions:")
                            .foregroundColor(Color("Color 6"))
                            .font(.title)
                        
                        Divider().frame(height: 2.0).background(
                            Color("Color 1")
                        ).padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Circle().frame(width: 5, height: 5).foregroundColor(Color("Color 1")) // Custom bullet point
                                Text("Select all of the employees that showed up on time and didnt leave early")
                                    .foregroundColor(Color("Color 6"))
                            }
                            .padding()
                            HStack {
                                Circle().frame(width: 5, height: 5).foregroundColor(Color("Color 1")) // Custom bullet point
                                Text("At the bottom, select the amount of hours that everyone worked for the day")
                                    .foregroundColor(Color("Color 6"))
                            }
                            .padding()
                            HStack {
                                Circle().frame(width: 5, height: 5).foregroundColor(Color("Color 1")) // Custom bullet point
                                Text("If your tuning in time for an employee who showed up late, left early or came from another job, select")
                                    .foregroundColor(Color("Color 6"))
                                +
                                Text(" Individual Hours").bold().fontWeight(.heavy)
                                    .foregroundColor(Color.blue)
                                +
                                Text(" otherwise, click")
                                    .foregroundColor(Color("Color 6"))
                                +
                                Text(" Next").bold().fontWeight(.heavy)
                                    .foregroundColor(Color.blue)
                            }
                            .padding()
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                    .background(Color("Color 5")) // Replace 'YourBackgroundColor' with desired color
                    .cornerRadius(8)
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .font(.headline)
            ScrollView {
                darkmode()
                ForEach(dataManager.employeeNames, id: \.self) { employeeName in
                    EmployeeSelectionRow(
                        name: employeeName, isSelected: selectedEmployees.contains(employeeName)
                    ) {
                        if let index = selectedEmployees.firstIndex(of: employeeName) {
                            selectedEmployees.remove(at: index) // Toggle employee selection
                        } else {
                            selectedEmployees.append(employeeName)
                        }
                    }
                }
            }
           
                    
            Divider().frame(height: 2.0).background(
                Color("Color 2")
            ).padding(.horizontal)
            
            Picker("Hours Worked", selection: $selectedHours) {
                ForEach(0 ..< 49, id: \.self) { index in
                    let hours = index / 2
                    let minutes = (index % 2) * 30
                    if minutes == 0 {
                        Text("\(hours) hours")
                            .foregroundColor(Color("Color 3"))
                        
                            .tag(index)
                    } else {
                        Text("\(hours) hours \(minutes) minutes")
                            .foregroundColor(Color("Color 3"))
                            .tag(index)
                    }
                }
            }
            .disabled(!isEmployeeComplete)
            .opacity(isEmployeeComplete ? 1.0 : 0.5) // Adjust opacity based on the selection status
            .pickerStyle(WheelPickerStyle())
            .labelsHidden()
            .onChange(of: selectedHours) { newValue in
                let hours = newValue / 2
                let minutes = (newValue % 2) * 30
                var userSelectedHours = ""
                if minutes == 0 {
                    userSelectedHours = "\(hours) hours"
                } else {
                    userSelectedHours = "\(hours) hours \(minutes) minutes"
                }
                
                for employeeName in selectedEmployees {
                    dataManager.saveEmployeeHours(name: employeeName, hours: userSelectedHours)
                }
            }
            Divider().frame(height: 2.0).background(
                Color("Color 2")
            ).padding(.horizontal)
            HStack {
                NavigationLink(destination: EmployeesViews().environmentObject(dataManager), isActive: $isNavigatingToEmployeesView) {
                    EmptyView()
                }
                Button(action: {
                    // Change the value to control navigation
                    isNavigatingToEmployeesView = true
                }) {
                    Text("Individual Hours")
                        .padding(.leading)
                }
                Spacer()
                
                NavigationLink(destination: PreViews().environmentObject(dataManager), isActive: $showPreView) {
                    EmptyView()
                }
                Button(action: {
                    showPreView = true
                }) {
                    Text("Submit")
                        .padding(.horizontal)
                        .disabled(!isSelectionComplete)
                        .opacity(isSelectionComplete ? 1.0 : 0.5)
                }
            }
            //                NavigationLink(
            //                    destination: PreViews().environmentObject(dataManager), isActive: $showPreView
            //                ) {
            //                    EmptyView()
            //                }
            //                .hidden()
            //                Button("Submit") {
            //                    // Save entered hours and route to PreView
            //                    showPreView = true
            //                }
            //                .buttonStyle(PlainButtonStyle())
            //                .padding(.horizontal)
            //                .disabled(!isSelectionComplete)
            //                .opacity(isSelectionComplete ? 1.0 : 0.5) // Adjust opacity based on the selection status
        }.background(EllipticalGradient(colors:[Color("Color 7"), Color("Color 8")], center: .top, startRadiusFraction: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, endRadiusFraction: 0.8))
        
            .font(colorScheme == .dark ? .headline : .headline)
            .onAppear {
                // Show instructions only once when the view appears
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        showInstructions = true
                    }
                }
            }.toolbar{MyToolbarItems()}
            .navigationBarBackButtonHidden(true) // Hides the back button
            .navigationBarHidden(true)
            .onChange(of: dataManager.isDarkMode) { newValue in
                UserDefaults.standard.set(newValue, forKey: "isDarkMode")
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.rootViewController?.overrideUserInterfaceStyle = newValue ? .dark : .light
                }
            }
        
    }
        
    //        .foregroundColor(colorScheme == .dark ? Color.blue : Color.black)
        
    
    private func backgroundBasedOnColorScheme() -> Color {
        if colorScheme == .dark {
            return (Color(white: 3.0, opacity: 0.1))
            
        } else {
            return Color.white // Change this to your desired light mode color
        }
    }
}
struct EmployeeSelectionRow: View {
    let name: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        HStack {
            Text(name)
                .foregroundColor(isSelected ? .green : .blue)
            
            Spacer()
            
            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isSelected ? .green : .gray)
        }
        .padding(.horizontal)
        .padding(.vertical, 2)
        .contentShape(Rectangle()) // Set the shape for the hit testing area
        .onTapGesture {
            action() // Perform action when the row is tapped
        }
    }
}

@available(iOS 17.0, *)
struct EmployeeView_Previews: PreviewProvider {

    static var previews: some View {
        EmployeeView()
            .environmentObject(DataManager())
    }
}
