//
//  DrivingView.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 1/11/23.
//

import SwiftUI

struct DrivingView: View {

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
                
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: UnloadOrdersView()) {
                        Button("Finish Drive") {}
                            .buttonStyle(GreenSemiBold24Button())
                            .padding(.trailing)
                    }
                    
                    Spacer()
                }
            }
        }
        .onAppear {
            self.getTripByBookingId(self.bookingIdString)
        }
    }
}

private extension DrivingView {
    func getTripByBookingId(_ bookingID: String) {
        tripStore.getTripByBookingID(bookingID: bookingID)
    }
}

struct DrivingView_Previews: PreviewProvider {
    static var previews: some View {
        DrivingView()
    }
}
