//
//  HomeMapView.swift
//  HomegateTestAssignmentUIKit
//
//  Created by Vladimir Lukic on 25.10.21..
//

import UIKit
import GoogleMaps
import CoreLocation

class HomeMapView: UIView, GMSMapViewDelegate {
    
    // MARK: Outlets
    
    // Google maps view
    @IBOutlet weak var mapView: GMSMapView!
    
    // MARK: Properties
    
    var context: HomeViewController!
        
    // Latitude from 45.83203 to 47.69732 and longitude from 6.07544 to 9.83723.
    let swissCamera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 46.80479636693669, longitude: 8.219356276094913, zoom: 7.0)
    
    var propertyMarkers: [GMSMarker]!
    
    var gmInfoView: GoogleMapsInfoView? = nil
    
    // MARK: Configuration

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    func configureMapView() {
        
        // Set camera to swiss initially
        self.resetCamera()
        mapView.delegate = self
    }
    
    // MARK: Map functions
    
    // Reset camera
    func resetCamera() {
        self.mapView.camera = swissCamera
    }
    
    // Center map to provided location
    func centerMap(on coordinate: CLLocationCoordinate2D) {
        
        // Get new camera position
        let cameraPosition = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: self.mapView.camera.zoom)
        
        // Animate map to new camera position
        self.mapView.animate(to: cameraPosition)
    }
    
    // Update map to show list of coordinates of properties from API
    func updateMapWithCoordinates() {
        
        // Set default map for empty properties
        if self.context.propertyList.count == 0 {
            self.resetCamera()
            return
        }
        
        // Init pin array
        self.propertyMarkers = [GMSMarker]()
        
        // Convert string location of property to GMSMarker
        for property in self.context.propertyList {
            
            // Do not add fault coordinates
            guard let location = property.geoLocation else { continue }
            if location.isEmpty == true { continue }
            
            // Get lat and lng
            let latLngArrayString = location.components(separatedBy: ",")
            let lat: CLLocationDegrees = Double(latLngArrayString[0]) ?? 0
            let lng: CLLocationDegrees = Double(latLngArrayString[1]) ?? 0
            if lat == 0 || lng == 0 { continue }
            
            // Configure marker
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: lng))
            marker.icon = UIImage(named: "ic-pin")
            marker.userData = property
            
            // Add marker to array
            propertyMarkers.append(marker)
        }
        
        // Prepare bounds of map to fit markers
        var bounds = GMSCoordinateBounds()
        
        // Add markers to map in main thread
        DispatchQueue.main.async {
            for marker in self.propertyMarkers {
                marker.map = self.mapView
                
                // Update bounds
                bounds = bounds.includingCoordinate(marker.position)
                
            }
            
            // Fit markers to map
            let update = GMSCameraUpdate.fit(bounds, withPadding: 64.0)
            self.mapView.animate(with: update)
        }
    }
    
    // MARK: Map delegate
    
    // Camera position change
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        // print(position.target.latitude, position.target.longitude, position.zoom)
    }
    
    // Tap on marker occured
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        // Get params
        let y = self.frame.size.height - 120.0 - 16.0 // height - info height - padding
        let model = marker.userData as? PropertyModel ?? PropertyModel()
        
        // Guard info view
        guard let gmInfoView = self.gmInfoView else {
            
            // Create new Info view if not existing
            self.gmInfoView = GoogleMapsInfoView.createGMInfoView(y: y, model: model, context: self.context)
            self.addSubview(self.gmInfoView ?? UIView())
            self.bringSubviewToFront(self.gmInfoView ?? UIView())
            
            // Animate adding
            UIView.animate(withDuration: 0.15, delay: 0.0, options: .transitionCrossDissolve) {
                self.gmInfoView?.alpha = 1.0
            } completion: { completed in}
            
            // Center map
            self.centerMap(on: marker.position)
            
            // Finalise delegate method
            return true
        }
        
        // Add new model and reconfigure info view
        gmInfoView.model = model
        UIView.animate(withDuration: 0.15, delay: 0.0, options: .transitionCrossDissolve) {
            gmInfoView.configureView(alpha: 1.0)
        } completion: { completed in}
        
        // Center map
        self.centerMap(on: marker.position)

        // Finalise delegate method
        return true
    }
    
    // Tap on coordinate occured
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        // Close marker info
        if self.gmInfoView != nil {
            UIView.animate(withDuration: 0.15, delay: 0.0, options: .transitionCrossDissolve) {
                self.gmInfoView?.alpha = 0.0
            } completion: { completed in
                
                // Remove from superview
                self.gmInfoView?.removeFromSuperview()
                self.gmInfoView = nil
            }
        }
    }
}
