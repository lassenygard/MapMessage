// GoogleMapView.swift
// MapMessage
//
// Created by Lasse Nygård on 15/03/2023.
//


import SwiftUI
import GoogleMaps
struct GoogleMapView: UIViewRepresentable {
var location: CLLocation

func makeUIView(context: Context) -> GMSMapView {
    let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 18)
    let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    mapView.isMyLocationEnabled = true
    return mapView
}

func updateUIView(_ uiView: GMSMapView, context: Context) {
    let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 18)
    uiView.animate(to: camera)
}
}

struct GoogleMapView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleMapView(location: CLLocation(latitude: 37.7749, longitude: -122.4194)).environmentObject(LocationNotificationService())
    }
}


////  GoogleMapView.swift
////  MapMessage
////
////  Created by Lasse Nygård on 15/03/2023.
////
//
//import SwiftUI
//import GoogleMaps
//
//struct GoogleMapView: UIViewRepresentable {
//    var location: CLLocation
//
//    func makeUIView(context: Context) -> GMSMapView {
//        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 18)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        mapView.isMyLocationEnabled = true
//        return mapView
//    }
//
//    func updateUIView(_ uiView: GMSMapView, context: Context) {
//        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 18)
//        uiView.animate(to: camera)
//    }
//}
//
//struct GoogleMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        GoogleMapView(location: CLLocation(latitude: 37.7749, longitude: -122.4194)).environmentObject(LocationManager())
//    }
//}
