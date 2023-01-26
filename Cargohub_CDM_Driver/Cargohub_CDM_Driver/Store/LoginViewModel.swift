//
//  LoginViewModel.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 1/20/23.
//

import Foundation
import SwiftUI
import JWTDecode

class LoginViewModel: ObservableObject {
    
    var email: String = ""
    var password: String = ""
    @Published var loginAlert: Bool = false
    @Published var isSigningIn: Bool = false
    
    func login(completion: @escaping (Bool) -> Void) {
        
        let defaults = UserDefaults.standard
        isSigningIn = true
        
        CargoAPI().login(email: email, password: password) { result in
            switch result {
            case .success(let token):
                defaults.setValue(token, forKey: "jsonwebtoken")
                
                do {
                    let jwt = try decode(jwt: token)
                    
                    if let driverID = jwt["http://schemas.xmlsoap.org/ws/2005/05/identity/claims/sid"].string {
                        defaults.setValue(driverID, forKey: "driverID")
                    }
                } catch {
                    print(error)
                }
                
                DispatchQueue.main.async {
                    self.isSigningIn = false
                }
                completion(true)
            case .failure(let error):
                self.loginAlert = true
                self.isSigningIn = false
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}
