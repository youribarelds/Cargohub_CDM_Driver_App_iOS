//
//  API.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 12/10/22.
//

import Foundation
import Combine

class CargoAPI {
    // MARK: Properties
    private var cancellables: [AnyCancellable] = []
    let baseURL = "https://cargohubcdm.azurewebsites.net/api"

    // MARK: Methods
    func fetchTripByBookingID(bookingID: String, completion: @escaping (Result<Trip, Error>) -> Void) {
        let url = URL(string: "\(baseURL)/Trips?BookingID=\(bookingID)")!
        fetch(type: AllTripsResponse.self, url: url, completion: { result in
            switch result {
            case .success(let response):
                let trip = Trip(bookingID: response.value.bookingID,
                                driverID: response.value.driverID,
                                vehicleID: response.value.vehicleID,
                                pickupHandler: response.value.pickupHandler,
                                pickUpAddress: response.value.pickUpAddress,
                                pickUpAddressLatLong: response.value.pickUpAddressLatLong,
                                airportPickup: response.value.airportPickup,
                                dropOffHandler: response.value.dropOffHandler,
                                airportDrop: response.value.airportDrop,
                                unloadingAddress: response.value.unloadingAddress,
                                unloadingAddressLatLong: response.value.unloadingAddressLatLong,
                                status: response.value.status,
                                startDateTime: response.value.startDateTime,
                                distanceKM: response.value.distanceKM,
                                estimatedArrivalTime: response.value.estimatedArrivalTime,
                                currentLocation: response.value.currentLocation)
                completion(.success(trip))
            case .failure(let error):
                print("fail")
                completion(.failure(error))
            }
        })
    }
    
    func fetchOrdersByBookingID(bookingID: String, completion: @escaping (Result<[Order], Error>) -> Void) {
        let url = URL(string: "\(baseURL)/Orders/\(bookingID)")!
        fetch(type: AllOrderResponse.self, url: url, completion: { result in
            switch result {
            case .success(let response):
                let orders = response.value
                    .enumerated()
                    .map({ (i, entity) in
                        return Order(id: i + 1, orderID: entity.orderID, bookingID: entity.bookingID, vehicleID: entity.vehicleID, mrnNumber: entity.mrnNumber, pickupDate: entity.pickupDate, pickupTime: entity.pickupTime, timeSlot: entity.timeSlot, status: entity.status, companyID: entity.companyID, image: entity.image)
                    })
                completion(.success(orders))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func fetchAirwaybillsByOrderID(orderID: String, completion: @escaping (Result<[Airwaybill], Error>) -> Void) {
        let urlString = "\(baseURL)/AirwayBills/order?OrderID=\(orderID.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
                      
        fetch(type: AllAirwaybillsResponse.self, url: url, completion: { result in
            switch result {
            case .success(let response):
                let airwaybills = response.value
                    .enumerated()
                    .map({ (i, entity) in
                        return Airwaybill(id: i + 1, airwayBillID: entity.airwayBillID, orderID: entity.orderID, package: entity.package, pcs: entity.pcs, weight: entity.weight, volume: entity.volume, lm: entity.lm, height: entity.height, dgr: entity.dgr, nature: entity.nature)
                    })
                completion(.success(airwaybills))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func updateOrderByOrderID(orderID: String, newStatus: String, completionHandler: @escaping (Result<Order, Error>) -> Void) {
        let urlString = "\(baseURL)/Orders/\(orderID.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")/\(newStatus)"

        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching films: \(error)")
                return
            }
                  
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                    return
            }
        })

        task.resume()
    }
    
    func updateTripByBookingID(bookingID: String, newStatus: String, completionHandler: @escaping (Result<Trip, Error>) -> Void) {
        let urlString = "\(baseURL)/Trips/Status?BookingID=\(bookingID)&Status=\(newStatus)"

        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching films: \(error)")
                return
            }
                  
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                    return
            }
        })
        
        Cargohub_CDM_DriverApp.statusesArray.statuses.insert("\(newStatus)", at: Cargohub_CDM_DriverApp.statusesArray.statuses.endIndex)
        
        print(Cargohub_CDM_DriverApp.statusesArray.statuses)

        task.resume()
    }
}

// MARK: Helpers
private extension CargoAPI {
    
    func fetch<T: Decodable>(type: T.Type, url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .finished:
                        break
                    case .failure(let error):
                        completion(.failure(error))
                    }
                },
                receiveValue: { response in
                    completion(.success(response))
                }
            )
            .store(in: &cancellables)
    }
}
