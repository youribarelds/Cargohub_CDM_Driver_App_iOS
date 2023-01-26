//
//  Cargohub_CDM_DriverApp.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 11/30/22.
//

import SwiftUI

@main
struct Cargohub_CDM_DriverApp: App {
    @StateObject var authentication = Authentication()
    @StateObject var viewManager = ViewManager()
    @StateObject var tripStore = TripStore()
    @StateObject var orderStore = OrderStore()
    @StateObject var airwaybillStore = AirwaybillStore()
    
    var body: some Scene {
        WindowGroup {
            if authentication.isValidated && viewManager.showPlannedTrips {
                PlannedTripsView()
                    .environmentObject(authentication)
                    .environmentObject(viewManager)
                    .environmentObject(tripStore)
                    .environmentObject(orderStore)
                    .environmentObject(airwaybillStore)
            }
            else if authentication.isValidated && viewManager.showLoadingActiveTrips {
                ActiveTripsView()
                    .environmentObject(authentication)
                    .environmentObject(viewManager)
                    .environmentObject(tripStore)
                    .environmentObject(orderStore)
                    .environmentObject(airwaybillStore)
            }
            else if authentication.isValidated && viewManager.showClosedTrips {
                ClosedTripView()
                    .environmentObject(authentication)
                    .environmentObject(viewManager)
                    .environmentObject(tripStore)
                    .environmentObject(orderStore)
                    .environmentObject(airwaybillStore)
            }
            else if authentication.isValidated && viewManager.showLoadingOrders {
                LoadOrdersView()
                    .environmentObject(authentication)
                    .environmentObject(viewManager)
                    .environmentObject(tripStore)
                    .environmentObject(orderStore)
                    .environmentObject(airwaybillStore)
            }
            else if authentication.isValidated && viewManager.showDriving {
                DrivingView()
                    .environmentObject(authentication)
                    .environmentObject(viewManager)
                    .environmentObject(tripStore)
                    .environmentObject(orderStore)
                    .environmentObject(airwaybillStore)
            }
            else if authentication.isValidated && viewManager.showUnloadingActiveTrips {
                UnloadActiveTripView()
                    .environmentObject(authentication)
                    .environmentObject(viewManager)
                    .environmentObject(tripStore)
                    .environmentObject(orderStore)
                    .environmentObject(airwaybillStore)
            }
            else if authentication.isValidated && viewManager.showUnloadingOrders {
                UnloadOrdersView()
                    .environmentObject(authentication)
                    .environmentObject(viewManager)
                    .environmentObject(tripStore)
                    .environmentObject(orderStore)
                    .environmentObject(airwaybillStore)
            }
            else {
                LoginView()
                    .environmentObject(authentication)
                    .environmentObject(viewManager)
            }
        }
    }
}
