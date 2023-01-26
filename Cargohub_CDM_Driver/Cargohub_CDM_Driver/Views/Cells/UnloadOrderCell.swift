//
//  UnloadOrderCell.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 1/11/23.
//

import SwiftUI

struct UnloadOrderCell: View {
    
    
    @EnvironmentObject var tripStore: TripStore
    @EnvironmentObject var orderStore: OrderStore
    @EnvironmentObject var airwaybillStore: AirwaybillStore
    
    let order: Order
    
    var body: some View {
        VStack {
            HStack {
                Text("Ordernumber:  \(order.orderID)")
                Spacer()
                
                if order.status != "UNLOADED" {
                    Button("Not Unloaded") {}
                        .buttonStyle(RedMedium12Button())
                }
                else {
                    Button("Unloaded") {}
                        .buttonStyle(GreenMedium12Button())
                }
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
            
            HStack {
                Button("Add Document To Order"){}
                    .buttonStyle(BlueMedium14Button())
                
                Spacer()

                Button("Add Image To Order"){}
                    .buttonStyle(BlueMedium14Button())
            }
            
            HStack {
                VStack {
                    HStack {
                        Text("Airwaybills")
                            .padding(.trailing, 60)
                            .padding(.leading, 0)
                        
                        Text("Pieces")
                        
                        Spacer()
                    }
                    
                    ForEach(airwaybillStore.airwaybills) { airwaybill in
                        UnloadAirwaybillCell(airwaybill: airwaybill)
                    }
                }
                
                Spacer()
            }
            .padding(.leading, 10)
            
            HStack {
                Spacer()
                
                if order.status != "UNLOADED" {
                    Button("Confirm Order") { updateOrder(orderID: order.orderID) }
                        .buttonStyle(GreenBold15Button())
                        .disabled(false)
                }
                else {
                    Button("Confirm Order") { updateOrder(orderID: order.orderID) }
                        .buttonStyle(GreenBold15Button())
                        .disabled(true)
                }
            }
            .padding(.bottom, 10)
            .padding(.trailing, 10)
        }
        .background(Color("TripBackground"))
        .padding(.bottom, 10)
        .onAppear {
            self.getAirwaybillsByOrderId(order.orderID)
        }
    }
}

private extension UnloadOrderCell {
    
    func getAirwaybillsByOrderId(_ orderID: String) {
        airwaybillStore.getAirwaybillsByOrderID(orderID: orderID)
    }
    
    func updateOrder(orderID: String) {
        orderStore.updateOrder(orderID: orderID, newStatus: "UNLOADED")
        
        if tripStore.activeTrips.count == 1 {
            if tripStore.activeTripBookingID.isEmpty {
                tripStore.activeTripBookingID = tripStore.activeTrips.first!.bookingID
            }
            
            orderStore.getOrdersByBookingID(bookingID: tripStore.activeTripBookingID)
        }
        
        orderStore.checkOrdersLoaded()
    }
}
