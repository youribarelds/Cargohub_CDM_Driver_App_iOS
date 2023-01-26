//
//  DrivingView.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 1/11/23.
//

import SwiftUI

struct DrivingView: View {

    @EnvironmentObject var tripStore: TripStore
    @EnvironmentObject var viewManager: ViewManager
    
    @State var isDriving = true

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                
                // Buttons top of screen
                HStack {
                    Spacer()
                    
                    Button("Active Trips") {}
                        .buttonStyle(BlueBold15Button())
                        .disabled(true)
                    
                    Button("Planned Trips") {
                        viewManager.showPlannedTripsView()
                    }
                    .buttonStyle(WhiteBold15Button())

                    Button("Closed Trips") {
                        viewManager.showClosedTripsView()
                    }
                    .buttonStyle(WhiteBold15Button())
                    
                    Spacer()
                }
                .padding(.bottom, 20)
                .padding(.top, 10)
                
                // Show Active Trip
                if (tripStore.activeTrips.count > 0) {
                    ForEach(tripStore.activeTrips) { trip in
                        DrivingTripCell(trip: trip)
                    }
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    if isDriving {
                        Button("Pause Drive") {
                            isDriving = false
                        }
                        .buttonStyle(OrangeSemiBold24Button())
                    }
                    else {
                        Button("Resume Drive") {
                            isDriving = true
                        }
                        .buttonStyle(GreenSemiBold24Button())
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct DrivingView_Previews: PreviewProvider {
    static var previews: some View {
        DrivingView()
    }
}
