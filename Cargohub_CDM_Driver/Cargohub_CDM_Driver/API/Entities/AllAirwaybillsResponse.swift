//
//  AllAirwaybillsResponse.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 1/9/23.
//

import Foundation

struct AllAirwaybillsResponse: Decodable {
    
    let value: [AirwaybillEntity]
}

struct AirwaybillEntity: Decodable {
    
    let airwayBillID: String
    let orderID: String
    let package: String
    let pcs: String
    let weight: String
    let volume: String
    let lm: String
    let height: String
    let dgr: String
    let nature: String
}
