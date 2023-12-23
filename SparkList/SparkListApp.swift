import SwiftUI
import UserNotifications
import ContactsUI
import AVFoundation

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            for request in requests {
                print("Pending request: \(request.identifier)")
            }
        }
        // Request notification permissions
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
        
        // Configure audio session
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to configure AVAudioSession: \(error.localizedDescription)")
        }

        // Set the AppDelegate as the delegate for UNUserNotificationCenter
        UNUserNotificationCenter.current().delegate = self

        return true
    }

    // Handle the notification when the app is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Notification will present: \(notification.request.identifier)")
        if notification.request.identifier == "dailyAlarm" {
            handleDailyAlarmResponse()
            
        }
        completionHandler([.banner, .sound]) // Customize as needed
    }

    // Handle the user's interaction with the notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Notification received with identifier: \(response.notification.request.identifier)")
        if response.notification.request.identifier == "dailyAlarm" {
            handleDailyAlarmResponse()
        }
        completionHandler()
    }

    // Logic to handle the response to the daily alarm
    func handleDailyAlarmResponse() {
        // Access the shared instance of your DataManager
        // Check if persistent mode is enabled and trigger a persistent alarm
    }
}

let dataManager = DataManager()

@available(iOS 17.0, *)
@main
struct SparkListApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var showSplash = true // Flag to control splash screen visibility

    var body: some Scene {
           WindowGroup {
               if showSplash {
                   LaunchScreen()
                       .onAppear {
                           DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Adjust the duration (e.g., 2 seconds)
                               withAnimation {
                                   showSplash = false // Hide the splash screen after delay
                               }
                           }
                       }
               } else {
                   ContentView()
                       .environmentObject(dataManager) // Inject the EnvironmentObject
               }
           }
       }
   }
