//
//  Helpers.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 12/12/22.
//

import Foundation

extension Bundle {
    
    func fetchData<T: Decodable>(url: String, model: T.Type, completion:@escaping(T) -> ()){
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            
            let serverData = try! JSONDecoder().decode(T.self, from: data)
            
            DispatchQueue.main.async {
                completion(serverData)
            }
        }
        .resume()
    }
}
