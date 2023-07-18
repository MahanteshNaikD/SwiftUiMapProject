//
//  LocaionsView.swift
//  SwiftMappROJECT
//
//  Created by Brigosha_Guest on 03/07/23.
//

import SwiftUI
import MapKit



struct LocaionsView: View {
    
    @EnvironmentObject private var vm:LocationVieModel
    
    
    var body: some View {
        ZStack {
            
            
            mapLayer
                .ignoresSafeArea()
            
            
            
            VStack(spacing: 0, content: {
                header
                    .padding()
                    .frame(maxWidth: 700)
                Spacer()
                LocationPreviewStack
                   
            })
            
        }
        .sheet(item: $vm.sheetLocation,onDismiss: nil) { location in
            LocationDeatilsView(location: location)
        }
        
    }
}

struct LocaionsView_Previews: PreviewProvider {
    
    static var previews: some View {
        LocaionsView()
            .environmentObject(LocationVieModel())
        
    }
}



extension LocaionsView {
    private var header:some View {
        
        
        VStack {
            
            Button (action: vm.ToggleLocationlList ){
                
                Text(vm.mapLocation.name + ","+vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.primary)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading, content: {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationList ? 180 : 0))
                    } )
            }
            
            if (vm.showLocationList){
                LocationListView()
            }
            
            
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20 ,x: 0,y: 15)
        
        
    }
    
    
    
    private var mapLayer : some View {
        
        Map(coordinateRegion:  $vm.mapRegion, annotationItems: vm.location, annotationContent: {
            location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotation()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(loction: location)
                    }
                
            }
        })
    }
    
    
    private var LocationPreviewStack : some View {
        ZStack {
            ForEach(vm.location){locations in
                
                if vm.mapLocation == locations {
                    LocationPreviewView(location: locations)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
                
                
            }
        }
    }
}
