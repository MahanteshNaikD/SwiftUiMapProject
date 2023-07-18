//
//  LocationPreviewView.swift
//  SwiftMappROJECT
//
//  Created by Brigosha_Guest on 04/07/23.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject private var vm:LocationVieModel
    
    let location:Location
    
    var body: some View {
        
        HStack(alignment: .bottom,spacing: 8) {
            VStack (alignment: .leading, spacing: 16){
                imageView
                textView
            }
            
            
            
            VStack(spacing: 8) {
                learnMoreButton
                NextButton
            }
            
        }
        .padding(20)
        .background(RoundedRectangle(cornerRadius: 10)
            .fill(.ultraThinMaterial)
            .offset(y:50)
        )
        .cornerRadius(10)
        
    }
}

struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            LocationPreviewView(location: LocationsDataService.locations.first!)
                .padding()
        }
        .environmentObject(LocationVieModel())
    }
}



extension LocationPreviewView{
    private var imageView : some View {
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100,height: 100)
                    .cornerRadius(10)
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
        
    }
    
    
    
    private var textView : some View {
        VStack(alignment: .leading,spacing: 4) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(location.cityName)
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        
    }
    
    
    private var learnMoreButton : some View {
        Button{
            vm.sheetLocation = location
        }label: {
            Text("Learn More")
                .font(.headline)
                .frame(width: 125,height: 35)
        }
        .buttonStyle(.borderedProminent)
        
    }
    
    
    private var NextButton : some View {
        Button{
            vm.nextButtonPressed()
        }label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125,height: 35)
        }
        .buttonStyle(.bordered)
    }
}
