//
//  LoadOrdersView.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 12/14/22.
//

import SwiftUI

struct LoadOrdersView: View {
    @EnvironmentObject var tripStore: TripStore
    @EnvironmentObject var orderStore: OrderStore
    @EnvironmentObject var airwaybillStore: AirwaybillStore
    
    @Environment(\.dismiss) var dismiss
    
    let bookingIdString = "AMS002647859"
    
    var body: some View {
        VStack {
            List(orderStore.orders) { order in
                
                UnloadOrderCell(order: order)
            }
            HStack {
                Button("Delay") {}
                    .buttonStyle(OrangeSemiBold24Button())
                    .padding(10)
                Spacer()
                Button("Finish Loading") { finishUnloading() }
                    .buttonStyle(GreenSemiBold24Button())
                    .padding(10)
            }
        }
        .onAppear{
            self.getOrdersByBookingId(self.bookingIdString)
        }
        .navigationTitle("Orders")
    }
}

private extension LoadOrdersView {
    func getOrdersByBookingId(_  bookingID: String) {
        orderStore.getOrders(bookingID: bookingID)
    }
    
    func finishUnloading() {
        tripStore.changeTripStatus(bookingID: bookingIdString, newStatus: "CargoLoaded")
        
        dismiss()
    }
}

struct LoadOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        LoadOrdersView()
    }
}
