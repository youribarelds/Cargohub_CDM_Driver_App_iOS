//
//  TripStore.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 12/10/22.
//

import Foundation

class TripStore: ObservableObject {
    
    @Published var plannedTrips: [Trip] = []
    @Published var activeTrips: [Trip] = []
    @Published var closedTrips: [Trip] = []
    @Published var trip: Trip?
    @Published var tripActiveStatus: String = ""
    @Published var tripStatuses: [String] = []
    @Published var activeTripBookingID: String = ""
    
    private let tripAPI: CargoAPI = CargoAPI()
    
    func getDriverTripsToday(driverID: String) {
        
        if plannedTrips.count == 0 {
            let defaults = UserDefaults.standard
            guard let token = defaults.string(forKey: "jsonwebtoken") else {
                return
            }
            
            let date = Date()
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "yyyy"
            let yearString = dateFormatter.string(from: date)
            
            dateFormatter.dateFormat = "MM"
            let monthString = dateFormatter.string(from: date)
            
            dateFormatter.dateFormat = "dd"
            let dayString = dateFormatter.string(from: date)

            tripAPI.fetchDriverTripsForToday(token: token, driverID: driverID, year: yearString, month: monthString, day: dayString, completion: { result in
                switch result {
                case .success(let trips):
                    DispatchQueue.main.async {
                        for trip in trips {
                            if trip.status == "DELIVERED" {
                                self.closedTrips.insert(trip, at: self.closedTrips.endIndex)
                            }
                            else if trip.status == "PLANNED" {
                                self.plannedTrips.insert(trip, at: self.plannedTrips.endIndex)
                            }
                            else {
                                self.activeTrips.insert(trip, at: self.activeTrips.endIndex)
                            }
                        }
                    }
                case .failure(let error):
                    print("error: \(error)")
                }
            })
        }
        else {
            return
        }
    }
    
    func changeTripStatus(newStatus: String) {
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        
        if activeTrips.count == 1 && activeTripBookingID.isEmpty {
            activeTripBookingID = activeTrips.first?.bookingID ?? ""
        }
        
        tripAPI.updateTripByBookingID(token: token, bookingID: activeTripBookingID, newStatus: newStatus, completionHandler: { result in
            switch result {
            case .success(let trip):
                self.tripActiveStatus = trip.status
                self.tripStatuses.insert("\(newStatus)", at: self.tripStatuses.endIndex)

                DispatchQueue.main.async {
                    self.trip = trip
                }
            case .failure(let error):
                print("error: \(error)")
            }
        })
    }
}
