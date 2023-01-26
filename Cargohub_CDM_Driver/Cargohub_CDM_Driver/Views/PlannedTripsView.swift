//
//  PlannedTripsView.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 1/26/23.
//

import SwiftUI

struct PlannedTripsView: View {
    
    @EnvironmentObject var viewManager: ViewManager
    @EnvironmentObject var tripStore: TripStore
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .leading) {

                // Buttons top of screen
                HStack {
                    Spacer()
                    
                    Button("Active Trips") {
                        viewManager.showLoadingActiveTripsView()
                    }
                    .buttonStyle(WhiteBold15Button())
                    
                    Button("Planned Trips") {}
                        .buttonStyle(BlueBold15Button())
                        .disabled(true)

                    Button("Closed Trips") {
                        viewManager.showClosedTripsView()
                    }
                    .buttonStyle(WhiteBold15Button())
                    
                    Spacer()
                }
                .padding(.bottom, 20)
                .padding(.top, 10)

                // Trips
                if tripStore.plannedTrips.count > 0 {
                    ForEach(tripStore.plannedTrips) { trip in
                        PlannedTripCell(trip: trip)
                    }
                }
                else {
                    HStack {
                        Spacer()
                        Text("No planned trips")
                        Spacer()
                    }
                }
                
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Trips today: \(Date.now.formatted(.dateTime.day().month().year()))")
                    .font(.semiBold24)
                    .foregroundColor(.white)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color("BlueButton"), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear {
            self.getTripByDriverId()
        }
    }
}

private extension PlannedTripsView {
    func getTripByDriverId() {
        
        guard let driverID = UserDefaults.standard.string(forKey: "driverID") else {
            return
        }

        tripStore.getDriverTripsToday(driverID: driverID)
    }
}

struct PlannedTripsView_Previews: PreviewProvider {
    static var previews: some View {
        PlannedTripsView()
    }
}
