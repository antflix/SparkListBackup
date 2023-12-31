//
//  project1App.swift
//  project1
//
//  Created by User on 11/23/23.
//
import SwiftUI
import UserNotifications
import ContactsUI
import AVFoundation

class AppDelegate: NSObject, UIApplicationDelegate {
    // Implement the app lifecycle methods as needed
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Perform any setup tasks here
        
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
        
        return true
    }
}
//
//
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//// Implement the app lifecycle methods as needed
//func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    // Perform any setup tasks here
//    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
//            if granted {
//                print("Notification permission granted")
//            } else {
//                print("Notification permission denied")
//            }
//        }
//    do {
//        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
//        try AVAudioSession.sharedInstance().setActive(true)
//    } catch {
//        print("Failed to configure AVAudioSession: \(error.localizedDescription)")
//    }
//    return true
//
//    // Inside AppDelegate or a relevant initialization part of your code
//    
//}
//}
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
