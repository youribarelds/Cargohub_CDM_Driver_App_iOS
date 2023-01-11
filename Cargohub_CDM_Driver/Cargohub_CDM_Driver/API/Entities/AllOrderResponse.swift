//
//  AllOrderResponse.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 12/14/22.
//

import Foundation

struct AllOrderResponse: Decodable {
    
    let value: [OrderEntity]
}

struct OrderEntity: Decodable {
    
    let orderID: String
    let bookingID: String
    let vehicleID: String
    let mrnNumber: String
    let pickupDate: String
    let pickupTime: String
    let timeSlot: String
    let status: String
    let companyID: String
    let image: String
}
