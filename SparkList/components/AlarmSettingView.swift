import SwiftUI
struct AlarmSettingView: View {
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        VStack {
            Text("Daily Notification Schedule:")
                .font(.title)
                .foregroundStyle(Color("Color 1"))
            DatePicker("", selection: $dataManager.selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .foregroundStyle(Color("Color 1")) // Use a wheel-style picker for time selection
            HStack{
                Button("Set Notification ") {
                    dataManager.scheduleAlarm(at: dataManager.selectedTime, soundName: dataManager.alarmNoise)
                    dataManager.isAlarmSet = true
                }.buttonStyle(PlainButtonStyle())
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                Button("Clear Notification") {
                    dataManager.cancelAlarm() // Function to cancel the notification
                    dataManager.isAlarmSet = false
                }.buttonStyle(PlainButtonStyle())
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Toggle("Persistent Mode", isOn: $dataManager.persistentMode)
                .onChange(of: dataManager.persistentMode) { newValue in
                    UserDefaults.standard.set(newValue, forKey: "persistentMode")
					print("persistent mode has changed")
                }
                .padding()
            Spacer()
            if dataManager.isAlarmSet {
                Text("Alarm is set for \(formattedTime(dataManager.selectedTime))")
                    .font(.callout) // Adjust the font size and style
                    .foregroundColor(.green) // Use a subdued color for the text
                    .italic() // Make it italic to indicate a status message
                    .padding(.top) // Add some top padding
            } else {
                Text("Alarm is not set")
                    .font(.callout) // Adjust the font size and style
                    .foregroundColor(.red) // Use a subdued color for the text
                    .italic() // Make it italic to indicate a status message
            }
        }
        .padding()
        
        
    }
    // Function to format time for display
    private func formattedTime(_ time: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: time)
    }
}
    // Function to schedule the alarm
    //    func scheduleAlarm(at time: Date, soundName: String) {
    //        let center = UNUserNotificationCenter.current()
    //
    //        let content = UNMutableNotificationContent()
    //        content.title = "Turn In Time!!"
    //        content.body = "It's time to turn in!"
    //        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "customAlarm-2.mp3"))
    //
    //        let calendar = Calendar.current
    //        let dateComponents = calendar.dateComponents([.hour, .minute], from: time)
    //
    //        var trigger: UNNotificationTrigger
    //
    //        let now = Date()
    //        var scheduledTime = time
    //        if now > scheduledTime {
    //            // Schedule for the next day
    //            scheduledTime = Calendar.current.date(byAdding: .day, value: 1, to: scheduledTime)!
    //        }
    //        if persistentMode {
    //               trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
    //           } else {
    //               trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.hour, .minute], from: scheduledTime), repeats: false)
    //           }
    //        let request = UNNotificationRequest(identifier: "timeAlarm", content: content, trigger: trigger)
    //
    //        center.add(request) { error in
    //            if let error = error {
    //                print("Error scheduling notification: \(error.localizedDescription)")
    //            } else {
    //                print("Notification scheduled successfully")
    //            }
    //        }
    //    }
    //
    //    // Function to cancel the alarm
    //    func cancelAlarm() {
    //        let center = UNUserNotificationCenter.current()
    //        center.removePendingNotificationRequests(withIdentifiers: ["timeAlarm"]) // Replace "dailyAlarm" with your notification identifier
    //    }
    //}

