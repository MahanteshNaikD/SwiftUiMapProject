//
//  LocationListView.swift
//  SwiftMappROJECT
//
//  Created by Brigosha_Guest on 03/07/23.
//

import SwiftUI

struct LocationListView: View {
    
    
    @EnvironmentObject private var vm:LocationVieModel
    var body: some View {
        List(content: {
            ForEach(vm.location){ location in
                
                Button {
                    vm.showNextLocation(loction: location)
                } label: {
                    listRowView(location: location)
                }
                .padding(.vertical,4)
                .listRowBackground(Color.clear)
                
              
                  
            }
        })
//        .background(Color.red)
        .listStyle(PlainListStyle())
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
            .environmentObject(LocationVieModel())
    }
}



extension LocationListView {
    private func listRowView(location:Location) -> some View{
        HStack {
            if let imageView = location.imageNames.first {
                Image(imageView)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45,height: 45)
                    .cornerRadius(10)
            }
            
            
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }.frame(maxWidth:.infinity,alignment: .leading)
        }
       
    }
}
