//
//  OrderStore.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 12/14/22.
//

import Foundation

class OrderStore: ObservableObject {
    
    @Published var orders: [Order] = []
    @Published var order: Order?
    
    private let orderAPI: CargoAPI = CargoAPI()
    
    func getOrders(bookingID: String) {
        orderAPI.fetchOrdersByBookingID(bookingID: bookingID, completion: { result in
            switch result {
            case .success(let orders):
                self.orders = orders
            case .failure(let error):
                print("error: \(error)")
            }
        })
    }
    
    func updateOrder(orderID: String, newStatus: String) {
        orderAPI.updateOrderByOrderID(orderID: orderID, newStatus: newStatus, completionHandler: { result in
            switch result {
            case .success(let order):
                self.order = order
            case .failure(let error):
                print("error: \(error)")
            }
        })
    }
}
