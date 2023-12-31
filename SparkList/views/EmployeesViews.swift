import SwiftUI

@available(iOS 17.0, *)
struct EmployeesViews: View {
    @EnvironmentObject var dataManager: DataManager // Access DataManager passed via environmentObject

    @State private var showingPopover = false // Create a state variable to control popover visibility
    @State var showPreView: Bool = false // Ensure it's declared as optional Bool?
    @State private var settingsPopover = false // Create a state variable to control popover visibility

    var isAnyEmployeeAssignedHours: Bool {
        // Check if any employee has assigned hours in DataManager

        return dataManager.employeeData.values.contains(where: { !$0.isEmpty })
    }

    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Employees").font(Font.custom("Quicksand", size: 30).bold())
                        .frame(maxWidth: .infinity * 0.90, alignment: .center)

                    Text("Different crews, Different Hours").font(Font.custom("Quicksand", size: 12).bold())
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

                        Divider()
                            .background(Color("Color 6"))

                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Circle().frame(width: 5, height: 5).foregroundColor(Color("Color 1")) // Custom bullet point
                                Text("Enter hours for each employee that you are turning in time for then, click").foregroundColor(Color("Color 6"))

                                    +
                                    Text(" Submit")
                                    .foregroundColor(Color("Color 1"))
                            }
                            .padding()
                            HStack {
                                Circle().frame(width: 5, height: 5).foregroundColor(Color("Color 1")) // Custom bullet point
                                Text("Use a decimal format-\n\t5.5 hours = 5 hours 30 minutes. ").foregroundColor(Color("Color 6"))
                            }
                            .padding()
                            HStack {
                                Circle().frame(width: 5, height: 5).foregroundColor(Color("Color 1")) // Custom bullet point
                                Text("All partial hour quantities will be rounded to the nearest 30 minutes.").foregroundColor(Color("Color 6"))
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

                ForEach(dataManager.employeeNames, id: \.self) { name in
                    EmployeeRowView(employeeName: name, dataManager: dataManager)
                        .padding(.bottom, 0)

                        .cornerRadius(8) // Optional: Add corner radius to rows
                }
            }
            NavigationLink(destination: PreViews().environmentObject(dataManager), isActive: $showPreView) {
                EmptyView()
            }
            Button(action: {
                showPreView = true
            }) {
                Text("Submit")
                    .padding(.horizontal)
                    .disabled(!isAnyEmployeeAssignedHours)
                    .opacity(isAnyEmployeeAssignedHours ? 1.0 : 0.5)
            }
//            Button(action: {
//                // Save entered hours and route to PreView
//                showPreView = true
//            }, label: {
//                Text("Submit")
//            })
//            .disabled(!isAnyEmployeeAssignedHours)
//            .navigationDestination(
//                isPresented: $showPreView) {
//                    PreViews().environmentObject(dataManager)
//                    Text("")
//            }
//            .environmentObject(dataManager) // Inject DataManager as environment object
//            .navigationBarBackButtonHidden(true) // Hides the back button
//            .navigationBarHidden(true)
        }.toolbar{MyToolbarItems()}
        .background(EllipticalGradient(colors: [Color("Color 7"), Color("Color 8")], center: .top, startRadiusFraction: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, endRadiusFraction: 0.8))
        .onChange(of: dataManager.isDarkMode) { newValue in
            UserDefaults.standard.set(newValue, forKey: "isDarkMode")
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.rootViewController?.overrideUserInterfaceStyle = newValue ? .dark : .light
            }
        }
    }
}

struct EmployeeRowView: View {
    let employeeName: String
    @ObservedObject var dataManager: DataManager

    @State private var enteredHours: String // State to store the entered hours by the user

    init(employeeName: String, dataManager: DataManager) {
        self.employeeName = employeeName
        self.dataManager = dataManager

        // Fetch the current hours for the employee from the DataManager when initializing the view
        _enteredHours = State(initialValue: dataManager.hoursForEmployee(employeeName))
    }

    var body: some View {
        HStack {
            Text(employeeName)

            Spacer()

            TextField("Enter Hours", text: $enteredHours)
                .keyboardType(.decimalPad)
                .padding(.vertical, 8) // Vertical padding
                .foregroundColor(.green.opacity(0.9)) // Text color
                .overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue)) // Underline
                .padding(.trailing)
                .onChange(of: enteredHours) { newValue in
                    // Add a delay before handling the entered value
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        // Check if the entered value is a valid double
                        if let value = Double(newValue), value >= 0.0 && value <= 24.0 {
                            // Check if the entered value is a whole number or has only one decimal place
                            let isWholeNumber = value.truncatingRemainder(dividingBy: 1) == 0
                            let hasOneDecimalPlace = (value * 10).truncatingRemainder(dividingBy: 1) == 0

                            if isWholeNumber || hasOneDecimalPlace {
                                let roundedValue = (value * 2).rounded() / 2 // Ensure hour and half-hour increments
                                let formattedHours = self.formatHours(roundedValue) // Get formatted hours
                                dataManager.saveEmployeeHours(name: employeeName, hours: formattedHours)
                                enteredHours = formattedHours // Update enteredHours with formatted value
                            }
                        }
                    } // Change placeholder text color
                }
                .foregroundColor(.red) // Change placeholder text color

                .keyboardType(.decimalPad)
        }
    }

    func formatHours(_ hours: Double) -> String {
        let totalMinutes = Int(hours * 60)
        let formattedHours = totalMinutes / 60
        let formattedMinutes = totalMinutes % 60
        if formattedMinutes == 0 {
            return "\(formattedHours) hours"
        } else if formattedMinutes % 30 == 0 {
            return "\(formattedHours) hours \(formattedMinutes) minutes"
        } else {
            return "\(formattedHours) hours \(formattedMinutes) minutes" // Return formatted string
        }
    }
}

@available(iOS 17.0, *)
struct EmployeesViews_Previews: PreviewProvider {
    static var previews: some View {
        EmployeesViews()
            .environmentObject(DataManager())
            .background(Color("Color 2"))
    }
}
