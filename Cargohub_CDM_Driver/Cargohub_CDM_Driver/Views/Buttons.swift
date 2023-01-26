//
//  Buttons.swift
//  Cargohub_CDM_Driver
//
//  Created by user225613 on 11/30/22.
//

import SwiftUI

struct BlueBold15Button: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.bold15)
            .foregroundColor(.white)
            .padding(8)
            .background(Color("BlueButton"))
            .cornerRadius(5)
    }
}

struct BlueMedium14Button: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.medium14)
            .foregroundColor(.white)
            .padding(8)
            .background(Color("BlueButton"))
    }
}

struct WhiteBold15Button: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.bold15)
            .foregroundColor(Color("BlackText"))
            .padding(8)
            .background(
                RoundedRectangle(
                    cornerRadius: 5,
                    style: .continuous
                ).fill(Color("WhiteButton"))
            )
            .overlay(
                RoundedRectangle(
                    cornerRadius: 5,
                    style: .continuous
                )
                .stroke(Color("Stroke"))
            )
    }
}

struct DarkBlueSemiBold20Button: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.semiBold20)
            .foregroundColor(.white)
            .padding([.leading, .trailing], 33)
            .padding([.top, .bottom], 13)
            .background(Color("DarkBlueButton"))
            .cornerRadius(5)
    }
}

struct RedMedium12Button: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.medium12)
            .foregroundColor(.black)
            .padding(8)
            .background(Color("RedButton"))
            .cornerRadius(5)
    }
}

struct RedMedium28Button: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.medium28)
            .foregroundColor(.white)
            .padding(8)
            .background(Color("RedButton"))
            .cornerRadius(5)
    }
}

struct GreenMedium12Button: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.medium12)
            .foregroundColor(.black)
            .padding(8)
            .background(Color("GreenButton"))
            .cornerRadius(5)
    }
}

struct OrangeSemiBold24Button: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.semiBold24)
            .foregroundColor(.white)
            .padding(8)
            .background(Color("OrangeButton"))
            .cornerRadius(5)
    }
}

struct LoadOrdersRemarksButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.semiBold24)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 8, leading: 30, bottom: 8, trailing: 30))
            .background(Color("OrangeButton"))
            .cornerRadius(5)
    }
}

struct UnloadOrdersRemarksButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.semiBold24)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 8, leading: 15, bottom: 8, trailing: 15))
            .background(Color("OrangeButton"))
            .cornerRadius(5)
    }
}

struct OrangeMedium14Button: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.medium14)
            .foregroundColor(.white)
            .padding(8)
            .background(Color("OrangeButton"))
            .cornerRadius(5)
    }
}

struct GreenSemiBold24Button: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.semiBold24)
            .foregroundColor(.white)
            .padding(8)
            .background(Color("GreenButton"))
            .cornerRadius(5)
    }
}

struct FinishLoadingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.semiBold24)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
            .background(Color("GreenButton"))
            .cornerRadius(5)
    }
}

struct GreenBold15Button: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.bold15)
            .foregroundColor(.white)
            .padding(8)
            .background(Color("GreenButton"))
            .cornerRadius(5)
    }
}

struct GreenMedium14Button: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.medium14)
            .foregroundColor(.white)
            .padding(8)
            .background(Color("GreenButton"))
            .cornerRadius(5)
    }
}

struct GreenMedium28Button: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.medium28)
            .foregroundColor(.white)
            .padding(8)
            .background(Color("GreenButton"))
            .cornerRadius(5)
    }
}


