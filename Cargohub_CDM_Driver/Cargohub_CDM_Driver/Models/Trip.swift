//
//  Trip.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 12/10/22.
//

import Foundation

struct Trip: Decodable, Identifiable, Equatable {
    
    var id: String { bookingID }
    let bookingID: String
    let driverID: String
    let vehicleID: String
    let pickupHandler: String
    let pickUpAddress: String
    let pickUpAddressLatLong: String
    let airportPickup: String
    let dropOffHandler: String
    let airportDrop: String
    let unloadingAddress: String
    let unloadingAddressLatLong: String
    let status: String
    let startDateTime: String
    let distanceKM: Double
    let estimatedArrivalTime: String
    let currentLocation: String
}
