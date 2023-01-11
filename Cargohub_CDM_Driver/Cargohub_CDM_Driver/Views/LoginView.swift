//
//  LoginView.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 11/30/22.
//

import SwiftUI

struct LoginView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color("BlueButton")
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("Login")
                    .font(.bold32)
                    .foregroundColor(.white)
                
                Text("Email:")
                    .font(.semiBold16)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                TextField(
                    "Email Address",
                    text: $username
                )
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                
                Text("Password:")
                    .font(.semiBold16)
                    .foregroundColor(.white)
                    .padding(.top, 30)
                
                SecureField(
                    "Password",
                    text: $password
                )
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                
                NavigationLink(destination: PlannedTripsView()) {
                    Button("Login") {}
                    .buttonStyle(DarkBlueSemiBold20Button())
                    .padding(.top, 15)
                }
                
                NavigationLink(destination: ForgotPasswordView()) {
                    Text("Forgot Password")
                        .font(.semiBold16)
                        .foregroundColor(.white)
                        .padding(.top, 40)
                }
            }
            .padding(.leading, 50)
            .padding(.trailing, 50)
            .textFieldStyle(.roundedBorder)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
