//
//  ActiveTripCell.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 1/25/23.
//

import SwiftUI

struct ActiveTripCell: View {
    
    @EnvironmentObject var tripStore: TripStore
    let trip: Trip
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text("\(trip.airportPickup) Airport")
                    .font(.bold18)
                    .foregroundColor(.black)

                Spacer()

                Image("arrow-right")
                    .frame(alignment: .center)

                Spacer()

                Text("\(trip.airportDrop) Airport")
                    .font(.bold18)
                    .foregroundColor(.black)

                Spacer()
            }

            HStack {
                Spacer()
                
                // left column
                VStack(alignment: .leading) {
                    Text("Pick up: \(trip.pickUpAddress)")
                        .font(.medium14)
                        .foregroundColor(.black)
                    
                    Text("Pick up time: \(trip.startDateTime)")
                        .font(.medium14)
                        .foregroundColor(.black)
                }
                
                // Input seperator line here
                Image("ic-seperator")
                
                // right column
                VStack(alignment: .leading) {
                    Text("Drop off: \(trip.unloadingAddress)")
                        .font(.medium14)
                        .foregroundColor(.black)
                        .padding(.leading)
                    
                    Text("Company: \(trip.dropOffHandler)")
                        .font(.medium14)
                        .foregroundColor(.black)
                        .padding(.leading)
                }
                
                Spacer()
            }
            
            HStack {
                Spacer()
                
                Button("Cancel") {
                    cancelTrip(trip: trip)
                }
                .buttonStyle(RedMedium28Button())
                .padding(.trailing)
                
                Spacer()
            }
        }
        .background(Color("TripBackground"))
        .padding(5)
    }
}

private extension ActiveTripCell {
    func cancelTrip(trip: Trip) {
        tripStore.plannedTrips.insert(trip, at: tripStore.plannedTrips.startIndex)

        if tripStore.activeTrips.contains(trip) {
            let index = tripStore.activeTrips.firstIndex(of: trip)
            tripStore.activeTrips.remove(at: index!)
        }
    }
}
