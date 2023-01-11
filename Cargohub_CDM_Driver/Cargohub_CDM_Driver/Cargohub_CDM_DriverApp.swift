//
//  Cargohub_CDM_DriverApp.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 11/30/22.
//

import SwiftUI

@main
struct Cargohub_CDM_DriverApp: App {
    @StateObject var tripStore = TripStore()
    @StateObject var orderStore = OrderStore()
    @StateObject var airwaybillStore = AirwaybillStore()
    
    struct statusesArray {
        
        static var statuses: [String] = []
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(tripStore)
                .environmentObject(orderStore)
                .environmentObject(airwaybillStore)
        }
    }
}
