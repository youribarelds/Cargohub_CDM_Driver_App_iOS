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
        Text(airwaybill.airwayBillID)
    }
}

//struct AirwaybillCell_Previews: PreviewProvider {
//    static var previews: some View {
//        AirwaybillCell()
//    }
//}
