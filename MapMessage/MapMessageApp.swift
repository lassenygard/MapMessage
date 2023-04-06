//  MapMessageApp.swift
//  MapMessage
//
//  Created by Lasse Nygård on 15/03/2023.
//

import SwiftUI
import GoogleMaps
import BackgroundTasks

@main
struct MapMessageApp: App {
    @UIApplicationDelegateAdaptor(AppNotificationDelegate.self) var appDelegate
    @StateObject private var locationNotificationService = LocationNotificationService()

    init() {
        // Initialize the Google Maps API key and other configurations
        let apiKey = "AIzaSyBXng7XwwmDToRoP0RPDXOvB5PCiV2vwRA"
        GMSServices.provideAPIKey(apiKey)

        // Register background tasks
        registerBackgroundTasks()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationNotificationService)
        }
    }

    func registerBackgroundTasks() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "no.nygardene.MapMessage.locationUpdate", using: nil) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
    }

    func handleAppRefresh(task: BGAppRefreshTask) {
        scheduleAppRefresh()

        // Send location data to server
        locationNotificationService.sendLocationToDeviceServer()

        // Complete the task
        task.setTaskCompleted(success: true)
    }

    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: "no.nygardene.MapMessage.locationUpdate")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 3600) // 1 hour

        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
}


////  MapMessageApp.swift
////  MapMessage
////
////  Created by Lasse Nygård on 15/03/2023.
////
//
//import SwiftUI
//import GoogleMaps
//import BackgroundTasks
//
//@main
//struct MapMessageApp: App {
//    @UIApplicationDelegateAdaptor(AppNotificationDelegate.self) var appDelegate
//
//    init() {
//        // Initialize the Google Maps API key and other configurations
//        let apiKey = "AIzaSyBXng7XwwmDToRoP0RPDXOvB5PCiV2vwRA"
//        GMSServices.provideAPIKey(apiKey)
//
//        // Register background tasks
//        registerBackgroundTasks()
//    }
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .environmentObject(appDelegate)
//        }
//    }
//
//    func registerBackgroundTasks() {
//        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.yourapp.MapMessage.locationUpdate", using: nil) { task in
//            self.handleAppRefresh(task: task as! BGAppRefreshTask)
//        }
//    }
//
//    func handleAppRefresh(task: BGAppRefreshTask) {
//        scheduleAppRefresh()
//
//        // Send location data to server
//        appDelegate.sendLocationToDeviceServer()
//
//        // Complete the task
//        task.setTaskCompleted(success: true)
//    }
//
//    func scheduleAppRefresh() {
//        let request = BGAppRefreshTaskRequest(identifier: "com.yourapp.MapMessage.locationUpdate")
//        request.earliestBeginDate = Date(timeIntervalSinceNow: 3600) // 1 hour
//
//        do {
//            try BGTaskScheduler.shared.submit(request)
//        } catch {
//            print("Could not schedule app refresh: \(error)")
//        }
//    }
//}
