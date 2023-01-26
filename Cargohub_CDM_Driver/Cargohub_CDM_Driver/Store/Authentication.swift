//
//  Authentication.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 1/22/23.
//

import Foundation
import SwiftUI

class Authentication: ObservableObject {
    @Published var isValidated = false
    
    func updateValidation(success: Bool) {
        withAnimation {
            DispatchQueue.main.async {
                self.isValidated = success
            }
        }
    }
}
