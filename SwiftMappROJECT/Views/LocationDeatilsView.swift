//
//  LocationDeatilsView.swift
//  SwiftMappROJECT
//
//  Created by Brigosha_Guest on 04/07/23.
//

import SwiftUI
import MapKit

struct LocationDeatilsView: View {
    
    @EnvironmentObject private var vm:LocationVieModel
    
    let location:Location
    
    var body: some View {
        ScrollView {
          
            VStack {
                iamgeSection
                    .shadow(color: Color.black.opacity(0.3), radius: 20,x: 0,y: 10)
                
                
                
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    Divider()
                    decriptionSection
                    Divider()
                    mapLayer
                   
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding()
            }
        }
        .background(.ultraThinMaterial)
        .ignoresSafeArea()
        .overlay(backButton,alignment:.topLeading)
       
    }
}

struct LocationDeatilsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDeatilsView(location: LocationsDataService.locations.first!)
            .environmentObject(LocationVieModel())
    }
}


extension LocationDeatilsView {
    private var iamgeSection : some View {
        TabView {
            ForEach(location.imageNames,id: \.self) { items in
                Image(items)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    
    
    private var titleSection :  some View {
        VStack (alignment: .leading, spacing: 8){
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    
    private var decriptionSection : some View {
        VStack (alignment: .leading, spacing: 8){
            Text(location.description)
                .font(.title3)
                .foregroundColor(.secondary)
            
            if  let url = URL(string: location.link) {
                Link("Read More On Wikipidia", destination: url)
                    .font(.headline)
                    .tint(.blue)
            }
            
          
        }
    }
    
    
    private var mapLayer : some View {
        
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: location.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))),
            annotationItems: [location]){ location in
            MapAnnotation(coordinate: location.coordinates){
                LocationMapAnnotation()
                    .shadow(radius: 10)
            }
            
        }
            .allowsHitTesting(false)
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(30)
    }
    
    
    
    private var backButton : some View{
       
        Button {
            vm.sheetLocation = nil
        }label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background()
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }
    }
}
