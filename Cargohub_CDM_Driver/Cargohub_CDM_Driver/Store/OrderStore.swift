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
    @Published var allOrdersLoaded = false
    @Published var allOrdersUnloaded = false
    
    private let orderAPI: CargoAPI = CargoAPI()

    func getOrdersByBookingID(bookingID: String) {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        
        orderAPI.fetchOrdersByBookingID(token: token, bookingID: bookingID, completion: { result in
            switch result {
            case .success(let orders):
                DispatchQueue.main.async {
                    self.orders = orders
                }
            case .failure(let error):
                print("error: \(error)")
            }
        })
    }
    
    func updateOrder(orderID: String, newStatus: String) {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        
        orderAPI.updateOrderByOrderID(token: token, orderID: orderID, newStatus: newStatus, completionHandler: { result in
            switch result {
            case .success(let order):
                DispatchQueue.main.async {
                    self.order = order
                }
                
            case .failure(let error):
                print("error: \(error)")
            }
        })
    }
    
    func checkOrdersLoaded() {
        for order in orders {
            print("\(order.orderID): \(order.status)")
            if order.status == "OPEN" {
                DispatchQueue.main.async {
                    self.allOrdersLoaded = false
                    return
                }
            }
        }
        
        DispatchQueue.main.async {
            self.allOrdersLoaded = true
        }
    }
    
    func checkOrdersUnloaded() {
        for order in orders {
            print("\(order.orderID): \(order.status)")
            if order.status == "LOADED" {
                DispatchQueue.main.async {
                    self.allOrdersUnloaded = false
                    return
                }
            }
        }
        
        DispatchQueue.main.async {
            self.allOrdersLoaded = true
        }
    }
}
