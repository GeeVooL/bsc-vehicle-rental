//
//  VehiclesListView.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 18/06/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import SwiftUI

struct VehiclesListView: View {
    let branchOffice: BranchOffice
    let vehicleType: VehicleType
    let engineType: EngineType
    @Binding var isRootActive: Bool
        
    var body: some View {
        List {
            ForEach(branchOffice.listVehicles(engineType: engineType, vehicleType: vehicleType),
                    id: \.self
            ) { vehicle in
                VehicleListRow(vehicle: vehicle, isRootActive: self.$isRootActive)
            }
        }
        .navigationBarTitle("Vehicles")
    }
}

struct VehiclesListView_Previews: PreviewProvider {
    @State static var tmp = true
    
    static var previews: some View {
        VehiclesListView(branchOffice: BranchOffice.all[0],
                         vehicleType: VehicleType.automobile,
                         engineType: EngineType.hybrid,
                         isRootActive: $tmp)
    }
}
