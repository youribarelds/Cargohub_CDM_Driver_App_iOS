//
//  LoginView.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 11/30/22.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var loginVM = LoginViewModel()
    @EnvironmentObject var authentication: Authentication
    @EnvironmentObject var viewManager: ViewManager

    
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
                
                TextField("Email Address", text: $loginVM.email)
                    .textContentType(.username)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
                
                Text("Password:")
                    .font(.semiBold16)
                    .foregroundColor(.white)
                    .padding(.top, 30)
                
                SecureField("Password", text: $loginVM.password)
                    .textContentType(.password)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                
                if loginVM.isSigningIn {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else {
                    Button("Login") {
                        loginVM.login { success in
                            viewManager.showPlannedTripsView()
                            authentication.updateValidation(success: success)
                        }
                    }
                    .buttonStyle(DarkBlueSemiBold20Button())
                    .padding(.top, 20)
                }
        
                Text("Forgot Password")
                    .font(.semiBold16)
                    .foregroundColor(.white)
                    .padding(.top, 40)
            }
            .padding(.leading, 50)
            .padding(.trailing, 50)
            .textFieldStyle(.roundedBorder)
            .alert(isPresented: $loginVM.loginAlert) {
                 Alert(title: Text("Login Error"),
                 message: Text("Please check email and password."),
                 dismissButton: .default(Text("Okay")))
            }
        }
    }
}
