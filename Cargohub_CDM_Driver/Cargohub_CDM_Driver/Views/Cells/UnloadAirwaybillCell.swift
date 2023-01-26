//
//  UnloadAirwaybillCell.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 1/11/23.
//

import SwiftUI

struct UnloadAirwaybillCell: View {
    
    let airwaybill: Airwaybill
    
    var body: some View {
        HStack {
            Text(airwaybill.airwayBillID)
                .padding(.trailing, 40)
            
            Text(airwaybill.pcs)
            Spacer()
            Button("Report Damage") {}
                .buttonStyle(OrangeMedium14Button())
                .padding(.trailing)
        }
    }
}

