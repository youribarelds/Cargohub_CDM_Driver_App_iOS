//
//  ActiveTripsView.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 11/30/22.
//

import SwiftUI

struct ActiveTripsView: View {
    
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
                .padding(.top, 10)

                // Trips
                if tripStore.activeTrips.count > 0 {
                    ForEach(tripStore.activeTrips) { trip in

                        ActiveTripCell(trip: trip)
                    }
                    
                    Spacer()
                    
                    // Trip Steps
                    VStack {
                        HStack {
                            Text("Gate in")
                            Spacer()

                            if tripStore.tripStatuses.contains("LoadingGateIn")  {
                                Button("Confirmed") {}
                                    .buttonStyle(GreenMedium14Button())
                                    .padding(.trailing)
                            }
                            else {
                                Button("Confirm") {
                                    tripStore.changeTripStatus(newStatus: "LoadingGateIn")
                                    
                                }
                                .buttonStyle(OrangeMedium14Button())
                                .padding(.trailing)
                            }
                        }

                        HStack {
                            Text("Office in")
                            Spacer()

                            if tripStore.tripStatuses.contains("LoadingOfficeIn")  {
                                Button("Confirmed") {}
                                    .buttonStyle(GreenMedium14Button())
                                    .padding(.trailing)
                            }
                            else {
                                Button("Confirm") {
                                    tripStore.changeTripStatus(newStatus: "LoadingOfficeIn")
                                    
                                }
                                .buttonStyle(OrangeMedium14Button())
                                .padding(.trailing)
                            }
                        }

                        HStack {
                            Text("Load orders")

                            Spacer()

                            if tripStore.tripStatuses.contains("CargoLoaded")  {
                                Button("Confirmed") {}
                                    .buttonStyle(GreenMedium14Button())
                                    .padding(.trailing)
                            }
                            else {
                                Button("Confirm") {
                                    viewManager.showTripOrdersView()
                                }
                                .buttonStyle(OrangeMedium14Button())
                                .padding(.trailing)
                            }
                        }

                        HStack {
                            Text("Office out")
                            Spacer()

                            if tripStore.tripStatuses.contains("LoadingOfficeOut")  {
                                Button("Confirmed") {}
                                    .buttonStyle(GreenMedium14Button())
                                    .padding(.trailing)
                            }
                            else {
                                Button("Confirm") {
                                    tripStore.changeTripStatus(newStatus: "LoadingOfficeOut")
                                    
                                }
                                .buttonStyle(OrangeMedium14Button())
                                .padding(.trailing)
                            }
                        }

                        HStack {
                            Text("Gate out")
                            Spacer()

                            if tripStore.tripStatuses.contains("LoadingGateOut")  {
                                Button("Confirmed") {}
                                    .buttonStyle(GreenMedium14Button())
                                    .padding(.trailing)
                            }
                            else {
                                Button("Confirm") {
                                    tripStore.changeTripStatus(newStatus: "LoadingGateOut")
                                    
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
                        
                        if ["LoadingGateIn", "LoadingOfficeIn", "CargoLoaded", "LoadingOfficeOut", "LoadingGateOut"].allSatisfy(tripStore.tripStatuses.contains) {
                            
                            Button("Start Driving") {
                                tripStore.changeTripStatus(newStatus: "DRIVING")
                                viewManager.showDrivingView()
                            }
                            .buttonStyle(GreenSemiBold24Button())
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom)
                }
                else {
                    HStack {
                        Spacer()
                        Text("No active trips")
                        Spacer()
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct ActiveTripsView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveTripsView()
    }
}
