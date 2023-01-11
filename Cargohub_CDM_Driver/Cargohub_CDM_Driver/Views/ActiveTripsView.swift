//
//  ActiveTripsView.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 11/30/22.
//

import SwiftUI

struct ActiveTripsView: View {

    @EnvironmentObject var tripStore: TripStore
    let bookingIdString = "AMS002647859"

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                
                Spacer()
                
                // Buttons top of screen
                NavigationView {
                    HStack {
                        NavigationLink(destination: ActiveTripsView()) {
                            Button("Planned Trips") {}
                                .buttonStyle(WhiteBold15Button())
                        }

                        NavigationLink(destination: ActiveTripsView()) {
                            Button("Active Trips") {}
                                .buttonStyle(BlueBold15Button())
                        }

                        NavigationLink(destination: ClosedTripView()) {
                            Button("Closed Trips") {}
                                .buttonStyle(WhiteBold15Button())
                        }
                    }
                }
                
                Spacer()
                
                // Trips
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Text("\(tripStore.trip?.airportPickup ?? "") Airport")
                            .font(.bold18)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Image("arrow-right")
                            .frame(alignment: .center)
                        
                        Spacer()
                        
                        Text("\(tripStore.trip?.airportDrop ?? "") Airport")
                            .font(.bold18)
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        
                        // left column
                        VStack(alignment: .leading) {
                            Text("Pick up: \(tripStore.trip?.pickUpAddress ?? "")")
                                .font(.medium14)
                                .foregroundColor(.black)
                            
                            Text("Pick up time: \(tripStore.trip?.startDateTime ?? "")")
                                .font(.medium14)
                                .foregroundColor(.black)
                            
                            Text("Driving time: 02:15 hours")
                                .font(.medium14)
                                .foregroundColor(.black)
                        }
                        
                        
                        // Input seperator line here
                        Image("ic-seperator")
                        
                        
                        // right column
                        VStack(alignment: .leading) {
                            Text("Drop off: \(tripStore.trip?.unloadingAddress ?? "")")
                                .font(.medium14)
                                .foregroundColor(.black)
                                .padding(.leading)
                            
                            Text("Order: 3")
                                .font(.medium14)
                                .foregroundColor(.black)
                                .padding(.leading)
                            
                            Text("Timeslot: 11:00 - 11:30")
                                .font(.medium14)
                                .foregroundColor(.black)
                                .padding(.leading)
                        }
                        
                        Spacer()
                    }
                }
                .background(Color("TripBackground"))
                .padding(5)
                
                Spacer()
                
                // Trip Steps
                List {
                    HStack {
                        Text("Gate in")
                        Spacer()
                        
                        if Cargohub_CDM_DriverApp.statusesArray.statuses.contains("LoadingGateIn")  {
                            Button("Confirmed") {}
                                .buttonStyle(GreenMedium14Button())
                                .padding(.trailing)
                        }
                        else {
                            Button("Confirm") {tripStore.changeTripStatus(bookingID: bookingIdString, newStatus: "LoadingGateIn")}
                                .buttonStyle(OrangeMedium14Button())
                                .padding(.trailing)
                        }
                    }
                    
                    HStack {
                        Text("Office in")
                        Spacer()
                        
                        if Cargohub_CDM_DriverApp.statusesArray.statuses.contains("LoadingOfficeIn")  {
                            Button("Confirmed") {}
                                .buttonStyle(GreenMedium14Button())
                                .padding(.trailing)
                        }
                        else {
                            Button("Confirm") {tripStore.changeTripStatus(bookingID: bookingIdString, newStatus: "LoadingOfficeIn")}
                                .buttonStyle(OrangeMedium14Button())
                                .padding(.trailing)
                        }
                    }

                    HStack {
                        Text("Load orders")
                        
                        Spacer()
                        
                        if Cargohub_CDM_DriverApp.statusesArray.statuses.contains("CargoLoaded")  {
                            Button("Confirmed") {}
                                .buttonStyle(GreenMedium14Button())
                                .padding(.trailing)
                        }
                        else {
                            NavigationLink(destination: LoadOrdersView()) {
                                Button("Confirm") {}
                                    .buttonStyle(OrangeMedium14Button())
                                    .padding(.trailing)
                            }
                        }
                        

                    }

                    HStack {
                        Text("Office out")
                        Spacer()
                        
                        if Cargohub_CDM_DriverApp.statusesArray.statuses.contains("LoadingOfficeOut")  {
                            Button("Confirmed") {}
                                .buttonStyle(GreenMedium14Button())
                                .padding(.trailing)
                        }
                        else {
                            Button("Confirm") {tripStore.changeTripStatus(bookingID: bookingIdString, newStatus: "LoadingOfficeOut")}
                                .buttonStyle(OrangeMedium14Button())
                                .padding(.trailing)
                        }
                    }

                    HStack {
                        Text("Gate out")
                        Spacer()
                        
                        if Cargohub_CDM_DriverApp.statusesArray.statuses.contains("LoadingGateOut")  {
                            Button("Confirmed") {}
                                .buttonStyle(GreenMedium14Button())
                                .padding(.trailing)
                        }
                        else {
                            Button("Confirm") {tripStore.changeTripStatus(bookingID: bookingIdString, newStatus: "LoadingGateOut")}
                                .buttonStyle(OrangeMedium14Button())
                                .padding(.trailing)
                        }
                        
                    }
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: DrivingView()) {
                        Button("Start Drive") {}
                            .buttonStyle(GreenSemiBold24Button())
                            .padding(.trailing)
                    }
                    
                    Spacer()
                }
                Spacer()
            }
        }
        .onAppear {
            self.getTripByBookingId(self.bookingIdString)
        }
    }
}

private extension ActiveTripsView {
    func getTripByBookingId(_ bookingID: String) {
        tripStore.getTripByBookingID(bookingID: bookingID)
    }
}

struct ActiveTripsView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveTripsView()
    }
}
