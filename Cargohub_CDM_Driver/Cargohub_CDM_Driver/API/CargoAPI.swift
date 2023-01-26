//
//  API.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 12/10/22.
//

import Foundation
import Combine

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

enum NetworkError: Error {
    case invalidURL(Error)
    case noData
    case serverError(statusCode: Int)
    case decodingError(Error)
}

struct LoginRequestBody: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    let accessToken: String?
    let message: String?
    let success: Bool?
}

class CargoAPI {
    
    // MARK: Properties
    let baseURL = "https://cargohubcdm.azurewebsites.net/api"

    // MARK: Methods
    func login(email: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        
        guard let url = URL(string: "https://cargohubcdm.azurewebsites.net/api/Users/Login") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = LoginRequestBody(email: email, password: password)
        
        var request  = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No Data: \(String(describing: error))")))
                return
            }
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let token = loginResponse.accessToken else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            completion(.success(token))
            
        }.resume()
    }
    
    func fetchDriverTripsForToday(token: String, driverID: String, year: String, month: String, day: String, completion: @escaping (Result<[Trip], NetworkError>) -> Void) {
        
        let url = URL(string: "\(baseURL)/Trips/DriverTrips?DriverID=\(driverID)&date=\(year)%2F\(month)%2F\(day)")!
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(.invalidURL(error)))
                return
            }
            
            if let data = data {
                if let trips = try? JSONDecoder().decode([Trip].self, from: data) {
                    completion(.success(trips))
                } else {
                    print("Invalid Response")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
            
        }.resume()
    }
    
    func fetchOrdersByBookingID(token: String, bookingID: String, completion: @escaping (Result<[Order], NetworkError>) -> Void) {
        
        let url = URL(string: "\(baseURL)/Orders/\(bookingID)")!
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(.invalidURL(error)))
                return
            }
            
            if let data = data {
                if let orders = try? JSONDecoder().decode([Order].self, from: data) {
                    completion(.success(orders))
                } else {
                    print("Invalid Response")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
            
        }.resume()
    }
    
    func fetchAirwaybillsByOrderID(token: String, orderID: String, completion: @escaping (Result<[Airwaybill], NetworkError>) -> Void) {
        
        let url = URL(string: "\(baseURL)/AirwayBills/order?OrderID=\(orderID.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")!
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(.invalidURL(error)))
                return
            }
            
            if let data = data {
                if let airwaybills = try? JSONDecoder().decode([Airwaybill].self, from: data) {
                    completion(.success(airwaybills))
                } else {
                    print("Invalid Response")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
            
        }.resume()
    }
    
    func updateTripByBookingID(token: String, bookingID: String, newStatus: String, completionHandler: @escaping (Result<Trip, Error>) -> Void) {
        let urlString = "\(baseURL)/Trips/Status?BookingID=\(bookingID)&Status=\(newStatus)"

        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PUT"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error updating trip: \(error)")
                return
            }
                  
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                    return
            }
            
            if let data = data {
                if let trip = try? JSONDecoder().decode(Trip.self, from: data) {
                    completionHandler(.success(trip))
                }
                else {
                    print("Invalid Response")
                }
            }
        }
        task.resume()
    }
    
    func updateOrderByOrderID(token: String, orderID: String, newStatus: String, completionHandler: @escaping (Result<Order, Error>) -> Void) {
        let urlString = "\(baseURL)/Orders/\(orderID.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")/\(newStatus)"

        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PUT"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error updating order: \(error)")
                return
            }
                  
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                    return
            }
            
            if let data = data {
                if let order = try? JSONDecoder().decode(Order.self, from: data) {
                    completionHandler(.success(order))
                }
                else {
                    print("Invalid Response")
                }
            }
        }
        task.resume()
    }
}
