//
//  LocationvVieModel.swift
//  SwiftMappROJECT
//
//  Created by Brigosha_Guest on 03/07/23.
//

import Foundation
import MapKit
import SwiftUI

class LocationVieModel :ObservableObject {
    
    @Published var location:[Location]
    
    @Published var mapLocation:Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    @Published var mapRegion:MKCoordinateRegion = MKCoordinateRegion()
    
    let mSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    
    @Published var showLocationList: Bool  = false
    
    @Published var sheetLocation:Location? = nil
    
    init() {
        let locations = LocationsDataService.locations
        
        self.location = locations
        
        self.mapLocation = locations.first!
        
        self.updateMapRegion(location: locations.first!)
    }
    
    
    private func updateMapRegion(location:Location){
        mapRegion = MKCoordinateRegion(center: location.coordinates, span: mSpan)
    }
    
    
    
    public func ToggleLocationlList(){
        withAnimation(.easeInOut){
            showLocationList = !showLocationList
        }
    }
    
    
    
    func showNextLocation(loction:Location){
        withAnimation(.easeInOut){
            mapLocation = loction
            showLocationList = false
        }
    }
    
    
    func nextButtonPressed(){
        guard let currentIndex = location.firstIndex(where: {$0 == mapLocation}) else {return}
        
        let nextIndex = currentIndex+1
        
        guard location.indices.contains(nextIndex) else {
            guard let firstIndex = location.first  else {
                return
            }
            
            showNextLocation(loction: firstIndex)
            return
        }
        
        let nextLocation = location[nextIndex]
        showNextLocation(loction: nextLocation)
        
    }
    
}
