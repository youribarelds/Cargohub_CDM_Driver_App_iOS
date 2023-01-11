//
//  UnloadOrdersView.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 1/11/23.
//

import SwiftUI

struct UnloadOrdersView: View {
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
                Button("Remarks") {}
                    .buttonStyle(OrangeSemiBold24Button())
                    .padding(10)
                Spacer()
                Button("Finish Unloading") { finishLoading() }
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

private extension UnloadOrdersView {
    func getOrdersByBookingId(_  bookingID: String) {
        orderStore.getOrders(bookingID: bookingID)
    }
    
    func finishLoading() {
        tripStore.changeTripStatus(bookingID: bookingIdString, newStatus: "CargoUnloaded")
        
//        dismiss()
    }
}

struct UnloadOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        UnloadOrdersView()
    }
}
