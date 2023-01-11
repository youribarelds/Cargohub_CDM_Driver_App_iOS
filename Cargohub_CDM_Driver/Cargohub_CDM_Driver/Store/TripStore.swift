//
//  TripStore.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 12/10/22.
//

import Foundation

class TripStore: ObservableObject {
    
    @Published var trip: Trip?
    
    private let tripAPI: CargoAPI = CargoAPI()
    
    func getTripByBookingID(bookingID: String) {
        tripAPI.fetchTripByBookingID(bookingID: bookingID, completion: { result in
            switch result {
            case .success(let trip):
                self.trip = trip
            case .failure(let error):
                print("error: \(error)")
            }
        })
    }
    
    func changeTripStatus(bookingID: String, newStatus: String) {
        tripAPI.updateTripByBookingID(bookingID: bookingID, newStatus: newStatus, completionHandler: { result in
            switch result {
            case .success(let trip):
                self.trip = trip
            case .failure(let error):
                print("error: \(error)")
            }
        })
    }
}
