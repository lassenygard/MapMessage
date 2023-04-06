//  ContentView.swift
//  MapMessage
//
//  Created by Lasse Nygård on 15/03/2023.
//

import SwiftUI
import CoreLocation
import GoogleMaps

struct ContentView: View {
    @EnvironmentObject private var locationNotificationService: LocationNotificationService

    var body: some View {
        if let location = locationNotificationService.lastLocation {
            GoogleMapView(location: location)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    locationNotificationService.sendLocationToDeviceServer()
                }
        } else {
            Text("Waiting for location...")
                .onAppear(perform: locationNotificationService.checkLocationAuthorization)
        }
    }
}



////
////  ContentView.swift
////  MapMessage
////
////  Created by Lasse Nygård on 15/03/2023.
////
//
//import SwiftUI
//import CoreLocation
//import UserNotifications
//import GoogleMaps
//
//struct ContentView: View {
//    @StateObject private var locationManager = LocationManager()
//    @EnvironmentObject private var appDelegate: AppNotificationDelegate
//
//    var body: some View {
//        if let location = locationManager.lastLocation {
//            GoogleMapView(location: location)
//                .edgesIgnoringSafeArea(.all)
//                .onAppear {
//                    appDelegate.sendLocationToDeviceServer()
//                }
//        } else {
//            Text("Waiting for location...")
//                .onAppear(perform: locationManager.checkLocationAuthorization)
//        }
//    }
//}
//
//class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
//    private let locationManager = CLLocationManager()
//    private let notificationCenter = UNUserNotificationCenter.current()
//
//    @Published var lastLocation: CLLocation?
//
//    var notificationData: [String: Any]?
//    var region: CLCircularRegion?
//
//    override init() {
//        super.init()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.allowsBackgroundLocationUpdates = true
//        locationManager.pausesLocationUpdatesAutomatically = false
//        locationManager.requestAlwaysAuthorization()
//        locationManager.startUpdatingLocation()
//
//        // Set up notification settings
//        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
//        notificationCenter.requestAuthorization(options: options) { granted, error in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//            }
//        }
//
//        // Request remote notifications
//        DispatchQueue.main.async {
//            UIApplication.shared.registerForRemoteNotifications()
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        lastLocation = locations.last
//        print("Updated location: \(lastLocation?.coordinate.latitude ?? 0), \(lastLocation?.coordinate.longitude ?? 0)")
//
//        if let location = locations.first, let targetRegion = region, targetRegion.contains(location.coordinate) {
//            print("User is within the target region")
//            displayNotificationMessage()
//        }
//    }
//
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        switch manager.authorizationStatus {
//        case .authorizedWhenInUse, .authorizedAlways:
//            locationManager.requestLocation()
//            if let targetRegion = region {
//                locationManager.startMonitoring(for: targetRegion)
//            }
//        case .notDetermined:
//            locationManager.requestAlwaysAuthorization()
//        default:
//            break
//        }
//    }
//
//    func checkLocationAuthorization() {
//        switch locationManager.authorizationStatus {
//        case .authorizedWhenInUse, .authorizedAlways:
//            break
//        case .notDetermined:
//            locationManager.requestAlwaysAuthorization()
//        default:
//            break
//        }
//    }
//
//    func checkLocation() {
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.requestLocation()
//            if let targetRegion = region {
//                locationManager.startMonitoring(for: targetRegion)
//            }
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Error: \(error.localizedDescription)")
//    }
//
//    func displayNotificationMessage() {
//        guard let title = notificationData?["title"] as? String,
//              let message = notificationData?["body"] as? String else { return }
//
//        print("Displaying notification message: Title: \(title), Body: \(message)")
//
//        let content = UNMutableNotificationContent()
//        content.title = title
//        content.body = message
//        content.sound = UNNotificationSound.default
//
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//    notificationCenter.add(request) { error in
//        if let error = error {
//            print("Error: \(error.localizedDescription)")
//        }
//    }
//}
//}
//
//////
//////  ContentView.swift
//////  MapMessage
//////
//////  Created by Lasse Nygård on 15/03/2023.
//////
////
////import SwiftUI
////import CoreLocation
////import UserNotifications
////import GoogleMaps
////
////struct ContentView: View {
////    @StateObject private var locationManager = LocationManager()
////    @EnvironmentObject private var appDelegate: AppNotificationDelegate
////
////    var body: some View {
////        if let location = locationManager.lastLocation {
////            GoogleMapView(location: location)
////                .edgesIgnoringSafeArea(.all)
////                .onAppear {
////                    appDelegate.sendLocationToDeviceServer()
////                }
////        } else {
////            Text("Waiting for location...")
////        }
////    }
////}
////
////class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
////    private let locationManager = CLLocationManager()
////    private let notificationCenter = UNUserNotificationCenter.current()
////
////    @Published var lastLocation: CLLocation?
////
////    var notificationData: [String: Any]?
////    var region: CLCircularRegion?
////
////    override init() {
////        super.init()
////        locationManager.delegate = self
////        locationManager.desiredAccuracy = kCLLocationAccuracyBest
////        locationManager.allowsBackgroundLocationUpdates = true
////        locationManager.pausesLocationUpdatesAutomatically = false
////        locationManager.requestAlwaysAuthorization()
////        locationManager.startUpdatingLocation()
////
////        // Set up notification settings
////        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
////        notificationCenter.requestAuthorization(options: options) { granted, error in
////            if let error = error {
////                print("Error: \(error.localizedDescription)")
////            }
////        }
////
////        // Request remote notifications
////        DispatchQueue.main.async {
////            UIApplication.shared.registerForRemoteNotifications()
////        }
////    }
////
////    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
////        lastLocation = locations.last
////        print("Updated location: \(lastLocation?.coordinate.latitude ?? 0), \(lastLocation?.coordinate.longitude ?? 0)")
////
////        if let location = locations.first, let targetRegion = region, targetRegion.contains(location.coordinate) {
////            print("User is within the target region")
////            displayNotificationMessage()
////        }
////    }
////
////    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
////        switch manager.authorizationStatus {
////        case .authorizedWhenInUse, .authorizedAlways:
////            locationManager.requestLocation()
////            if let targetRegion = region {
////                locationManager.startMonitoring(for: targetRegion)
////            }
////        case .notDetermined:
////            locationManager.requestAlwaysAuthorization()
////        default:
////            break
////        }
////    }
////
////    func checkLocationAuthorization() {
////        switch locationManager.authorizationStatus {
////        case .authorizedWhenInUse, .authorizedAlways:
////            break
////        case .notDetermined:
////            locationManager.requestAlwaysAuthorization()
////        default:
////            break
////        }
////    }
////
////    func checkLocation() {
////        if CLLocationManager.locationServicesEnabled() {
////            locationManager.requestLocation()
////            if let targetRegion = region {
////                locationManager.startMonitoring(for: targetRegion)
////            }
////        }
////    }
////
////    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
////        print("Error: \(error.localizedDescription)")
////    }
////
////    func displayNotificationMessage() {
////        guard let title = notificationData?["title"] as? String,
////              let message = notificationData?["body"] as? String else { return }
////
////        print("Displaying notification message: Title: \(title), Body: \(message)")
////
////        let content = UNMutableNotificationContent()
////        content.title = title
////        content.body = message
////        content.sound = UNNotificationSound.default
////
////        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
////        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
////
////        notificationCenter.add(request) { error in
////            if let error = error {
////                print("Error: \(error.localizedDescription)")
////            }
////        }
////    }
////}
