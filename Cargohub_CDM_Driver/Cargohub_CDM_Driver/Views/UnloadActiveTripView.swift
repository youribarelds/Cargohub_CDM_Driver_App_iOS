//
//  UnloadActiveTripView.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 1/26/23.
//

import SwiftUI

struct UnloadActiveTripView: View {
    
    @EnvironmentObject var viewManager: ViewManager
    @EnvironmentObject var tripStore: TripStore
    @EnvironmentObject var authentication: Authentication

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

                Spacer()

                // Trips
                if tripStore.activeTrips.count > 0 {
                    ForEach(tripStore.activeTrips) { trip in

                        UnloadActiveTripCell(trip: trip)
                    }
                    
                    Spacer()
                    
                    // Trip Steps
                    VStack {
                        HStack {
                            Text("Gate in")
                            Spacer()

                            if tripStore.tripStatuses.contains("UnloadingGateIn")  {
                                Button("Confirmed") {}
                                    .buttonStyle(GreenMedium14Button())
                                    .padding(.trailing)
                            }
                            else {
                                Button("Confirm") {
                                    tripStore.changeTripStatus(newStatus: "UnloadingGateIn")
                                    
                                }
                                .buttonStyle(OrangeMedium14Button())
                                .padding(.trailing)
                            }
                        }

                        HStack {
                            Text("Office in")
                            Spacer()

                            if tripStore.tripStatuses.contains("UnloadingOfficeIn")  {
                                Button("Confirmed") {}
                                    .buttonStyle(GreenMedium14Button())
                                    .padding(.trailing)
                            }
                            else {
                                Button("Confirm") {
                                    tripStore.changeTripStatus(newStatus: "UnloadingOfficeIn")
                                    
                                }
                                .buttonStyle(OrangeMedium14Button())
                                .padding(.trailing)
                            }
                        }

                        HStack {
                            Text("Unload orders")

                            Spacer()

                            if tripStore.tripStatuses.contains("CargoUnloaded")  {
                                Button("Confirmed") {}
                                    .buttonStyle(GreenMedium14Button())
                                    .padding(.trailing)
                            }
                            else {
                                Button("Confirm") {
                                    viewManager.showUnloadingOrdersView()
                                }
                                .buttonStyle(OrangeMedium14Button())
                                .padding(.trailing)
                            }
                        }

                        HStack {
                            Text("Office out")
                            Spacer()

                            if tripStore.tripStatuses.contains("UnloadingOfficeOut")  {
                                Button("Confirmed") {}
                                    .buttonStyle(GreenMedium14Button())
                                    .padding(.trailing)
                            }
                            else {
                                Button("Confirm") {
                                    tripStore.changeTripStatus(newStatus: "UnloadingOfficeOut")
                                    
                                }
                                .buttonStyle(OrangeMedium14Button())
                                .padding(.trailing)
                            }
                        }

                        HStack {
                            Text("Gate out")
                            Spacer()

                            if tripStore.tripStatuses.contains("UnloadingGateOut")  {
                                Button("Confirmed") {}
                                    .buttonStyle(GreenMedium14Button())
                                    .padding(.trailing)
                            }
                            else {
                                Button("Confirm") {
                                    tripStore.changeTripStatus(newStatus: "UnloadingGateOut")
                                    
                                }
                                .buttonStyle(OrangeMedium14Button())
                                .padding(.trailing)
                            }
                        }
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 5)
                    
                    Spacer()

                    HStack {
                        Spacer()
                        
                        if ["UnloadingGateIn", "UnloadingOfficeIn", "CargoUnloaded", "UnloadingOfficeOut", "UnloadingGateOut"].allSatisfy(tripStore.tripStatuses.contains) {
                            
                            Button("Finish Trip") {
                                tripStore.changeTripStatus(newStatus: "DELIVERED")
                                finishTrip(trip: tripStore.activeTrips.first!)
                                viewManager.showPlannedTripsView()
                            }
                            .buttonStyle(GreenSemiBold24Button())
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom)
                }
            }
        }
    }
}

private extension UnloadActiveTripView {
    func finishTrip(trip: Trip) {
        tripStore.tripActiveStatus = trip.status
        tripStore.tripStatuses.removeAll()
        tripStore.closedTrips.insert(trip, at: tripStore.closedTrips.endIndex)
        
        if tripStore.activeTrips.contains(trip) {
            let index = tripStore.activeTrips.firstIndex(of: trip)
            tripStore.activeTrips.remove(at: index!)
        }
    }
}

struct UnloadActiveTripView_Previews: PreviewProvider {
    static var previews: some View {
        UnloadActiveTripView()
    }
}
