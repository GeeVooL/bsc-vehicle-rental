//
//  VehicleDetailsView.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 18/06/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import SwiftUI

struct VehicleDetailsView: View {
    var vehicle: Vehicle
    
    @Binding var isRootActive: Bool
    @Binding var isListActive: Bool
    
    var body: some View {
        VStack {
            List {
                HStack {
                    Image(vehicle.imageName ?? "missing")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipped()
                        .cornerRadius(10)
                        
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text("\(vehicle.brand!) \(vehicle.model!)").font(.headline)
                        Divider()
                        Text("Model year: \(String(vehicle.modelYear))")
                        Text("Colour: \(vehicle.color!)")
                        Text("Type: \(String(vehicle.vehicleType.name))")
                        Text("Engine: \(String(vehicle.engineType.name))")
                        Text("Price: $\(vehicle.pricePerDay!.stringValue)/day")
                    }
                    .padding()
                }
                
                ForEach(vehicle.getDetails().sorted(by: <), id: \.key) { key, value in
                    Section(header: Text(key)) {
                        Text(value)
                    }
                }
                
                NavigationLink(destination: RentDateView(vehicle: vehicle,
                                                         isRootActive: $isRootActive,
                                                         isListActive: $isListActive)
                ) {
                    Text("Choose the vehicle").foregroundColor(Color.blue)
                }
                .isDetailLink(false)
            }
        }
        .navigationBarTitle("Details")
    }
}

struct VehicleDetailsView_Previews: PreviewProvider {
    @State static var tmp = true
    
    static var previews: some View {
        VehicleDetailsView(vehicle: Vehicle.vehicles[0], isRootActive: $tmp, isListActive: $tmp)
    }
}
