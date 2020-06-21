//
//  BlueButtonStyle.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 18/06/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import SwiftUI

struct RoundedButtonStyle: ButtonStyle {
    var foregroundColor: Color = .blue
    var backgroundColor: Color = Color(red: 229, green: 229, blue: 234)
    
    public func makeBody(configuration: RoundedButtonStyle.Configuration) -> some View {
        configuration.label
            .foregroundColor(foregroundColor)
            .padding(15)
            .background(RoundedRectangle(cornerRadius: 5).fill(backgroundColor))
            .compositingGroup()
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}
