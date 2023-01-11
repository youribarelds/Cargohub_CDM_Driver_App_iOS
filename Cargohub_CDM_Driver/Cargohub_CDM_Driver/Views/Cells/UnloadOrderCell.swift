//
//  UnloadOrderCell.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 1/11/23.
//

import SwiftUI

struct UnloadOrderCell: View {
    
    @EnvironmentObject var orderStore: OrderStore
    @EnvironmentObject var airwaybillStore: AirwaybillStore
    let order: Order
    @State var orderLoaded = false
    
    var body: some View {
        VStack {
            HStack {
                Text(order.orderID)
                Spacer()
                
                if order.status != "UNLOADED" {
                    Button("Not Loaded") {}
                        .buttonStyle(RedMedium12Button())
                }
                else {
                    Button("Loaded") {}
                        .buttonStyle(GreenMedium12Button())
                }
            }
            
            VStack {
                ForEach(airwaybillStore.airwaybills) { airwaybill in
                    UnloadAirwaybillCell(airwaybill: airwaybill)
                }
            }
            
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
        }
        .padding(10)
        .onAppear {
            self.getAirwaybillsByOrderId(order.orderID)
        }
    }
}

private extension UnloadOrderCell {
    
    func getAirwaybillsByOrderId(_ orderID: String) {
        airwaybillStore.loadData(orderID: orderID)
    }
    
    func updateOrder(orderID: String) {
        orderStore.updateOrder(orderID: orderID, newStatus: "UNLOADED")
    }
}
