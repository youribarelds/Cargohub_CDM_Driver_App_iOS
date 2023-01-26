//
//  AirwaybillCell.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 1/9/23.
//

import SwiftUI

struct LoadAirwaybillCell: View {
    
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
