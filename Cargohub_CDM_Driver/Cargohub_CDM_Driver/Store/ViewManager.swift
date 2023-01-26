//
//  ViewManager.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 1/26/23.
//

import Foundation
import SwiftUI

class ViewManager: ObservableObject {
    
    @Published var showPlannedTrips = false
    @Published var showLoadingActiveTrips = false
    @Published var showClosedTrips = false
    @Published var showLoadingOrders = false
    @Published var showDriving = false
    @Published var showUnloadingActiveTrips = false
    @Published var showUnloadingOrders = false
    
    
    func showPlannedTripsView() {
        withAnimation {
            DispatchQueue.main.async {
                self.showPlannedTrips = true
                self.showLoadingActiveTrips = false
                self.showClosedTrips = false
                self.showLoadingOrders = false
                self.showDriving = false
                self.showUnloadingActiveTrips = false
                self.showUnloadingOrders = false
            }
        }
    }
    
    func showLoadingActiveTripsView() {
        withAnimation {
            DispatchQueue.main.async {
                self.showPlannedTrips = false
                self.showLoadingActiveTrips = true
                self.showClosedTrips = false
                self.showLoadingOrders = false
                self.showDriving = false
                self.showUnloadingActiveTrips = false
                self.showUnloadingOrders = false
            }
        }
    }
    
    func showClosedTripsView() {
        withAnimation {
            DispatchQueue.main.async {
                self.showPlannedTrips = false
                self.showLoadingActiveTrips = false
                self.showClosedTrips = true
                self.showLoadingOrders = false
                self.showDriving = false
                self.showUnloadingActiveTrips = false
                self.showUnloadingOrders = false
            }
        }
    }
    
    func showTripOrdersView() {
        withAnimation {
            DispatchQueue.main.async {
                self.showPlannedTrips = false
                self.showLoadingActiveTrips = false
                self.showClosedTrips = false
                self.showLoadingOrders = true
                self.showDriving = false
                self.showUnloadingActiveTrips = false
                self.showUnloadingOrders = false
            }
        }
    }
    
    func showDrivingView() {
        withAnimation {
            DispatchQueue.main.async {
                self.showPlannedTrips = false
                self.showLoadingActiveTrips = false
                self.showClosedTrips = false
                self.showLoadingOrders = false
                self.showDriving = true
                self.showUnloadingActiveTrips = false
                self.showUnloadingOrders = false
            }
        }
    }
    
    func showUnloadingActiveTripsView() {
        withAnimation {
            DispatchQueue.main.async {
                self.showPlannedTrips = false
                self.showLoadingActiveTrips = false
                self.showClosedTrips = false
                self.showLoadingOrders = false
                self.showDriving = false
                self.showUnloadingActiveTrips = true
                self.showUnloadingOrders = false
            }
        }
    }
    
    func showUnloadingOrdersView() {
        withAnimation {
            DispatchQueue.main.async {
                self.showPlannedTrips = false
                self.showLoadingActiveTrips = false
                self.showClosedTrips = false
                self.showLoadingOrders = false
                self.showDriving = false
                self.showUnloadingActiveTrips = false
                self.showUnloadingOrders = true
            }
        }
    }
}
