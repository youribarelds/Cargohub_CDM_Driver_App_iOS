//
//  Airwaybill.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 1/9/23.
//

import Foundation

struct Airwaybill: Decodable, Identifiable {
    
    let id: Int
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
