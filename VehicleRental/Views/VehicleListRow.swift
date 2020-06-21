//
//  VehicleListRow.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 18/06/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import SwiftUI

struct VehicleListRow: View {
    var vehicle: Vehicle
    
    @Binding var isRootActive: Bool
    
    @State var isListActive: Bool = false
    
    var body: some View {
        NavigationLink(destination: VehicleDetailsView(
            vehicle: vehicle,
            isRootActive: $isRootActive,
            isListActive: $isListActive),
                       isActive: $isListActive
        ) {
            HStack {
                Image(vehicle.imageName ?? "missing")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipped()
                    .cornerRadius(10)
                VStack(alignment: .leading) {
                    Text("\(vehicle.brand!) \(vehicle.model!)").font(.headline)
                    Text("\(String(vehicle.modelYear))").font(.subheadline)
                }
            }
        }
        .isDetailLink(false)
    }
}

struct VehicleListRow_Previews: PreviewProvider {
    @State static var tmp = true
    
    static var previews: some View {
        VehicleListRow(vehicle: Vehicle.vehicles[0], isRootActive: $tmp)
    }
}
