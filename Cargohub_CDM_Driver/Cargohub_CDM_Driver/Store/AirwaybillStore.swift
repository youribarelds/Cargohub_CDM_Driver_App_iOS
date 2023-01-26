//
//  AirwaybillStore.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 1/9/23.
//

import Foundation

class AirwaybillStore: ObservableObject {
    
    @Published var airwaybills: [Airwaybill] = []
    
    private let airwaybillAPI: CargoAPI = CargoAPI()
    
    func getAirwaybillsByOrderID(orderID: String) {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        
        airwaybillAPI.fetchAirwaybillsByOrderID(token: token, orderID: orderID, completion: { result in
            switch result {
            case .success(let airwaybills):
                DispatchQueue.main.async {
                    self.airwaybills = airwaybills
                }
            case .failure(let error):
                print("error: \(error)")
            }
        })
    }
}
