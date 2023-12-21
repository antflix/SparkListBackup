import SwiftUI
struct AlarmSettingView: View {
    @EnvironmentObject var dataManager: DataManager

    @State private var selectedTime = Date() // State to hold the selected time
    @State private var isAlarmSet = false // State to track if the alarm is set
    
    var body: some View {
        VStack {
            Text("Daily Notification Schedule:")
                .font(.title)
                .foregroundStyle(Color("Color 1"))
            DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .foregroundStyle(Color("Color 1")) // Use a wheel-style picker for time selection
            HStack{
                Button("Set Notification ") {
                    scheduleAlarm(at: selectedTime, soundName: "customAlarm-2.mp3")
                    isAlarmSet = true
                }.buttonStyle(PlainButtonStyle())
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
                Button("Clear Notification") {
                    cancelAlarm() // Function to cancel the notification
                    isAlarmSet = false
                }.buttonStyle(PlainButtonStyle())
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            // ... (existing code remains unchanged)
                 if isAlarmSet {
                     Text("Alarm is set for \(formattedTime(selectedTime))")
                         .padding()
                         .foregroundStyle(Color.red)
                 } else {
                     Text("Alarm is not set")
                         .foregroundStyle(Color.yellow)
                 }
        }
        .padding()
        .onAppear {
               // Retrieve the saved time from UserDefaults and assign it to selectedTime
               if let savedTime = UserDefaults.standard.object(forKey: "selectedTime") as? Date {
                   selectedTime = savedTime
                   isAlarmSet = true // Set isAlarmSet to true since time is retrieved
               }
           }
           .onDisappear {
               // Save the selectedTime to UserDefaults when the view disappears
               UserDefaults.standard.set(selectedTime, forKey: "selectedTime")
           }
       }
    
    // Function to format time for display
    private func formattedTime(_ time: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: time)
    }
    
    // Function to schedule the alarm
    func scheduleAlarm(at time: Date,  soundName: String) {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Turn In Time!!"
        content.body = "It's time to turn in!"
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: soundName))

        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute], from: time) // Extract hour and minute from the selected time
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "timeAlarm", content: content, trigger: trigger)
        
        center.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    // Function to cancel the alarm
    func cancelAlarm() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["timeAlarm"]) // Replace "dailyAlarm" with your notification identifier
    }
}
