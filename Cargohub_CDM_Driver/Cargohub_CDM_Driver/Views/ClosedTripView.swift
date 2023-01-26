//
//  ClosedTripView.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 11/30/22.
//

import SwiftUI

struct ClosedTripView: View {
    
    @EnvironmentObject var authentication: Authentication
    @EnvironmentObject var viewManager: ViewManager
    @EnvironmentObject var tripStore: TripStore
    
    var body: some View {
        
        // Buttons top of screen
        HStack {
            Spacer()
            
            Button("Active Trips") {
                viewManager.showLoadingActiveTripsView()
            }
            .buttonStyle(WhiteBold15Button())
            
            
            Button("Planned Trips") {
                viewManager.showPlannedTripsView()
            }
            .buttonStyle(WhiteBold15Button())

            Button("Closed Trips") {}
                .buttonStyle(BlueBold15Button())
                .disabled(true)
            
            Spacer()
        }
        .padding(.bottom, 20)
        .padding(.top, 10)
        
        if tripStore.closedTrips.count > 0 {
            ForEach(tripStore.closedTrips) { trip in
                ClosedTripCell(trip: trip)
            }
        }
        else {
            HStack {
                Spacer()
                Text("No closed trips")
                Spacer()
            }
        }

        Spacer()
    }
}

struct ClosedTripView_Previews: PreviewProvider {
    static var previews: some View {
        ClosedTripView()
    }
}
