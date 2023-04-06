//  AppNotificationDelegate.swift
//  MapMessage
//
//  Created by Lasse Nygård on 16/03/2023.
//


import UIKit
import UserNotifications
import CoreLocation

class AppNotificationDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var locationNotificationService: LocationNotificationService!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        locationNotificationService = LocationNotificationService()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Add any necessary actions
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Add any necessary actions
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Add any necessary actions
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Add any necessary actions
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Add any necessary actions
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Received remote notification: \(userInfo)")
        
        guard let aps = userInfo["aps"] as? [String: AnyObject], aps["content-available"] as? Int == 1 else {
            completionHandler(.noData)
            return
        }

        guard let data = userInfo["data"] as? [String: String],
              let alertTitle = data["alert_title"],
              let alertBody = data["alert_body"] else {
            completionHandler(.noData)
            return
        }

        locationNotificationService.notificationData = ["title": alertTitle, "body": alertBody]
        completionHandler(.newData)
    }
}


//import UIKit
//import UserNotifications
//import CoreLocation
//
//class AppNotificationDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, CLLocationManagerDelegate, ObservableObject {
//
//    var window: UIWindow?
//    var locationManager: CLLocationManager!
//    var regionInfo: (latNorth: Double, lngEast: Double, latSouth: Double, lngWest: Double)?
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        UNUserNotificationCenter.current().delegate = self
//        locationManager = CLLocationManager()
//        locationManager.delegate = self
//        locationManager.requestAlwaysAuthorization()
//
//        let center = UNUserNotificationCenter.current()
//        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
//            if granted {
//                print("Notification permission granted.")
//            } else {
//                print("Notification permission denied.")
//            }
//        }
//
//        return true
//    }
//
//    func applicationWillResignActive(_ application: UIApplication) {
//        sendLocationToDeviceServer()
//    }
//
//    func applicationDidEnterBackground(_ application: UIApplication) {
//        sendLocationToDeviceServer()
//    }
//
//    func applicationWillEnterForeground(_ application: UIApplication) {
//        sendLocationToDeviceServer()
//    }
//
//    func applicationDidBecomeActive(_ application: UIApplication) {
//        sendLocationToDeviceServer()
//    }
//
//    func applicationWillTerminate(_ application: UIApplication) {
//        sendLocationToDeviceServer()
//    }
//
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        print("Received remote notification: \(userInfo)")
//
//        guard let aps = userInfo["aps"] as? [String: AnyObject], aps["content-available"] as? Int == 1 else {
//            completionHandler(.noData)
//            return
//        }
//
//        guard let data = userInfo["data"] as? [String: String],
//              let latNorth = Double(data["lat_north"] ?? ""),
//              let lngEast = Double(data["lng_east"] ?? ""),
//              let latSouth = Double(data["lat_south"] ?? ""),
//              let lngWest = Double(data["lng_west"] ?? ""),
//              let alertTitle = data["alert_title"],
//              let alertBody = data["alert_body"] else {
//            completionHandler(.noData)
//            return
//        }
//
//        regionInfo = (latNorth: latNorth, lngEast: lngEast, latSouth: latSouth, lngWest: lngWest)
//
//        if let lastLocation = locationManager.location {
//            let userCoordinate = lastLocation.coordinate
//            if userCoordinate.latitude <= latNorth && userCoordinate.latitude >= latSouth && userCoordinate.longitude <= lngEast && userCoordinate.longitude >= lngWest {
//                print("Inside the region. Show the notification.")
//
//                // Show the notification
//                let content = UNMutableNotificationContent()
//
//                content.title = alertTitle
//                content.body = alertBody
//                content.sound = UNNotificationSound.default
//
//                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
//                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//                UNUserNotificationCenter.current().add(request) { error in
//                    if let error = error {
//                        print("Error: \(error.localizedDescription)")
//                    }
//                }
//            } else {
//                print("Outside the region. Do not show the notification.")
//            }
//        }
//        completionHandler(.newData)
//
//    }
//
//    func sendLocationToDeviceServer() {
//        // Implement the logic for sending the location data to your server
//        // Send location data to the device server
//        print("Sending location data to device server")
//    }
//
//    // CLLocationManagerDelegate methods
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let lastLocation = locations.last, let regionInfo = regionInfo {
//            let userCoordinate = lastLocation.coordinate
//            if userCoordinate.latitude <= regionInfo.latNorth && userCoordinate.latitude >= regionInfo.latSouth && userCoordinate.longitude <= regionInfo.lngEast && userCoordinate.longitude >= regionInfo.lngWest {
//                print("Inside the region. Show the notification.")
//            } else {
//                print("Outside the region. Do not show the notification.")
//            }
//        }
//    }
//}
