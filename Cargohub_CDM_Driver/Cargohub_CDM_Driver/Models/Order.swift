//
//  Order.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 12/14/22.
//

import Foundation

struct Order: Decodable, Identifiable, Equatable {
    
    var id: String { orderID }
    let orderID: String
    let bookingID: String
    let vehicleID: String
    let mrnNumber: String
    let pickupDate: String
    let pickupTime: String
    let timeSlot: String
    let status: String
    let companyID: String
}
