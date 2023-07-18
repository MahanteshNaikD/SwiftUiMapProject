//
//  SwiftMappROJECTApp.swift
//  SwiftMappROJECT
//
//  Created by Brigosha_Guest on 03/07/23.
//

import SwiftUI

@main
struct SwiftMappROJECTApp: App {
    
    @StateObject private var vm = LocationVieModel()
    
    var body: some Scene {
        WindowGroup {
            LocaionsView()
                .environmentObject(vm)
        }
    }
}
