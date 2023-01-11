//
//  ContentView.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 11/30/22.
//

import SwiftUI

struct ContentView: View {
//    let trip: Trip
    
    var body: some View {
        
        TabView {
            NavigationView {
//                ZStack {
//                    LoginView()
//                }

                ZStack {
                    ActiveTripsView()
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
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
