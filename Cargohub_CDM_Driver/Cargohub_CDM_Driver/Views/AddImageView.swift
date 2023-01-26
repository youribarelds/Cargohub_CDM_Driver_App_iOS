//
//  AddImageView.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 1/25/23.
//

import SwiftUI

struct AddImageView: View {
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {

                Spacer()
                
                Button("Open Camera") {}
                    .buttonStyle(GreenSemiBold24Button())
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Upload Files")
                    .font(.semiBold24)
                    .foregroundColor(.white)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color("BlueButton"), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct AddImageView_Previews: PreviewProvider {
    static var previews: some View {
        AddImageView()
    }
}
