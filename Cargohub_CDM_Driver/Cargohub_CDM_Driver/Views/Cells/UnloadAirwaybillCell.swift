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
        Text(airwaybill.airwayBillID)
    }
}

//struct UnloadAirwaybillCell_Previews: PreviewProvider {
//    static var previews: some View {
//        UnloadAirwaybillCell()
//    }
//}
