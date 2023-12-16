//
//  SettingsView.swift
//  SparkList
//
//  Created by User on 12/8/23.
//

import SwiftUI
@available(iOS 17.0, *)
struct modeSettingsView: View {
    @State var isSettingsOpen: Bool
    @EnvironmentObject var dataManager: DataManager

    var body: some View {
        VStack {
            // Your settings content goes here
            Text("Settings")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background(Color.white)
          .gesture(
              DragGesture()
                  .onChanged { value in
                      if value.translation.width < 0 {
                          // Open settings view with animation duration adjustment
                          withAnimation(.easeInOut(duration: 4.0)) {
                              isSettingsOpen = true
                          }
                      }
                  }
                .onEnded { value in
                    // Close settings view if swiped right
                    if value.translation.width > 50 {
                        withAnimation(.easeInOut(duration: 4.0)) {
                            isSettingsOpen = false
                        }
                    }
                }
        )
        
                .offset(x: isSettingsOpen ? 0 : UIScreen.main.bounds.width)
            }
        }
//struct SettingsView_Previews: PreviewProvider {
//    @StateObject var dataManager: DataManager // ... code for Employees view
////
//    static var previews: some View {
//        SettingsView(isSettingsOpen: Bool)
//            
//    }
//}
