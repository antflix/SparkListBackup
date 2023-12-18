//
//  AlarmSettingView.swift
//  SparkList
//
//  Created by User on 12/7/23.
//

import SwiftUI
struct AlarmSettingView: View {
    @EnvironmentObject var dataManager: DataManager

    @State private var selectedTime = Date() // State to hold the selected time
    @State private var isAlarmSet = false // State to track if the alarm is set
    
    var body: some View {
        VStack {
            Text("Daily Notification Schedule:")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundStyle(Color("Color 1"))
            DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .foregroundStyle(Color("Color 1"))// Use a wheel-style picker for time selection
            HStack{
                Button("Set Notification ") {
                    scheduleAlarm(at: selectedTime, soundName: "customalarm.mp3")
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
            if isAlarmSet {
                Text("Alarm is set for \(formattedTime(selectedTime))")
                    .padding()
                    .foregroundStyle(Color.red)
            }
            else {
                Text("Alarm is not set")
                    .foregroundStyle(Color.yellow)
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
    func scheduleAlarm(at time: Date,  soundName: String) {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Turn In Time!!"
        content.body = "Its time to turn in time!"
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: soundName))

        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute], from: time) // Extract hour and minute from the selected time
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "newAlarm", content: content, trigger: trigger)
        
        center.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
}
func cancelAlarm() {
    let center = UNUserNotificationCenter.current()
    center.removePendingNotificationRequests(withIdentifiers: ["newAlarm"]) // Replace "dailyAlarm" with your notification identifier
}
#if DEBUG
struct AlarmSettingView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmSettingView()
    }
}
#endif
