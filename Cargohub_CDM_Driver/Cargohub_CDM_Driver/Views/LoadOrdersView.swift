//
//  LoadOrdersView.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 12/14/22.
//

import SwiftUI

struct LoadOrdersView: View {
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
                LoadOrderCell(order: order)
            }
            
            VStack {
                Toggle("Security seal:", isOn: $securitySeal)
                
                Toggle("Douane seal:", isOn: $douaneSeal)
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button("Remarks") {}
                    .buttonStyle(LoadOrdersRemarksButton())
                
                Spacer()
                
                Button("Finish Loading") {
                    finishLoading()
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

private extension LoadOrdersView {
    func getOrdersByBookingId() {
        
        if tripStore.activeTrips.count == 1 {
            if tripStore.activeTripBookingID.isEmpty {
                tripStore.activeTripBookingID = tripStore.activeTrips.first!.bookingID
            }
            
            orderStore.getOrdersByBookingID(bookingID: tripStore.activeTripBookingID)
        }
    }
    
    func finishLoading() {
        tripStore.changeTripStatus(newStatus: "CargoLoaded")
        viewManager.showLoadingActiveTripsView()
    }
}
