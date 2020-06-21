//
//  ConfirmationSheet.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 20/06/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import SwiftUI

struct ConfirmationSheet: View {
    var reservationCode: String
    
    @Binding var showingConfirmationView: Bool
    @Binding var isRootActive: Bool
    @Binding var isListActive: Bool
    
    var body: some View {
        VStack {
            Text("You have successfully booked a vehicle").font(.headline).padding(.top)
            Spacer()
            Text("Your reservation code")
            Text(reservationCode).font(.largeTitle)
            Spacer()
            HStack {
                Button(action: {
                    self.isListActive.toggle()
                    self.showingConfirmationView.toggle()
                }) {
                    HStack{
                        Spacer()
                        Text("Book another")
                        Spacer()
                    }
                }
                .buttonStyle(RoundedButtonStyle(foregroundColor: .accentColor,
                                                backgroundColor: Color(red: 229.0 / 255.0,
                                                                       green: 229.0 / 255.0,
                                                                       blue: 234.0 / 255.0))
                )
                .padding(.trailing)
                
                Button(action: {
                    self.isRootActive.toggle()
                    self.showingConfirmationView.toggle()
                }) {
                    HStack{
                        Spacer()
                        Text("Done")
                        Spacer()
                    }
                }
                .buttonStyle(RoundedButtonStyle(foregroundColor: .accentColor,
                                                backgroundColor: Color(red: 229.0 / 255.0,
                                                                       green: 229.0 / 255.0,
                                                                       blue: 234.0 / 255.0))
                )
                .padding(.leading)
            }
            }
        .padding()
    }
}

struct ConfirmationSheet_Previews: PreviewProvider {
    @State static var tmp = true
    static var previews: some View {
        ConfirmationSheet(reservationCode: "Test",
                          showingConfirmationView: $tmp,
                          isRootActive: $tmp,
                          isListActive: $tmp)
    }
}
