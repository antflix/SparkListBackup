//
//  AlarmSettingView.swift
//  SparkList
//
//  Created by User on 12/7/23.
//
import SwiftUI
import UserNotifications
import AVFoundation

struct AlarmSettingView: View {
    @EnvironmentObject var dataManager: DataManager

    @State private var selectedTime = Date()
    @State private var isAlarmSet = false

    var body: some View {
        VStack {
            Text("Daily Notification Schedule:")
                .font(.title)
                .foregroundColor(Color("Color 1"))
            
            DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .foregroundColor(Color("Color 1"))
            
            HStack {
                Button("Set Notification ") {
                    scheduleAlarm(at: selectedTime)
                    isAlarmSet = true
                }.buttonStyle(PlainButtonStyle())
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("Clear Notification") {
                    cancelAlarm()
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
                    .foregroundColor(Color.red)
            } else {
                Text("Alarm is not set")
                    .foregroundColor(Color.yellow)
            }
        }
        .padding()
    }

    private func formattedTime(_ time: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: time)
    }

    func scheduleAlarm(at time: Date) {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Turn In Time!!"
        content.body = "It's time to turn in!"
        content.sound = UNNotificationSound.default
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute], from: time)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "newAlarm1", content: content, trigger: trigger)
        
        center.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification has been ran")
                // Call function to play sound at the selected time
                playSoundAtTime(time)
            }
        }
    }

    func cancelAlarm() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["newAlarm1"])
    }

    func playSoundAtTime(_ time: Date) {
        let currentTime = Date()
        let calendar = Calendar.current

        // Calculate the time difference between the current time and the selected time
        let difference = calendar.dateComponents([.second], from: currentTime, to: time).second ?? 0

        // Schedule the audio playback after the time difference
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(difference)) {
            do {
                guard let soundURL = Bundle.main.url(forResource: "alarm", withExtension: "mp3") else {
                    return
                }

                let audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer.play()
            } catch let error {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
}
