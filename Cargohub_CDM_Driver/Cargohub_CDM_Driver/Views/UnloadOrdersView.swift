//
//  UnloadOrdersView.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 1/11/23.
//

import SwiftUI

struct UnloadOrdersView: View {
    @EnvironmentObject var authentication: Authentication
    @EnvironmentObject var viewManager: ViewManager
    @EnvironmentObject var tripStore: TripStore
    @EnvironmentObject var orderStore: OrderStore
    @EnvironmentObject var airwaybillStore: AirwaybillStore

    @State var securitySeal = false
    @State var douaneSeal = false
    
    var body: some View {
        VStack {
            ForEach(orderStore.orders) { order in
                UnloadOrderCell(order: order)
            }
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button("Remarks") {}
                    .buttonStyle(UnloadOrdersRemarksButton())
                
                Spacer()
                
                Button("Finish Unloading") {
                    finishUnloading()
                }
                .buttonStyle(FinishLoadingButton())
                .disabled(!orderStore.allOrdersLoaded)
                
                Spacer()
            }
        }
        .onAppear{
            self.getOrdersByBookingId()
        }
        .navigationTitle("Orders")
    }
}

private extension UnloadOrdersView {
    func getOrdersByBookingId() {
        
        if tripStore.activeTrips.count == 1 {
            if tripStore.activeTripBookingID.isEmpty {
                tripStore.activeTripBookingID = tripStore.activeTrips.first!.bookingID
            }
            
            orderStore.getOrdersByBookingID(bookingID: tripStore.activeTripBookingID)
        }
    }
    
    func finishUnloading() {
        tripStore.changeTripStatus(newStatus: "CargoUnloaded")
        viewManager.showUnloadingActiveTripsView()
    }
}
