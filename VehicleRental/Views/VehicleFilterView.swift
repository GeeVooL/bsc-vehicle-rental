//
//  VehicleFilterView.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 17/06/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import SwiftUI

struct VehicleFilterView: View {
    @State private var branchOffice = BranchOffice.all[0]
    @State private var vehicleType = VehicleType.automobile
    @State private var engineType = EngineType.combustion
    @State private var isActive = false
    
    var body: some View {
        Form {
            Section(header: Text("Filters")) {
                Picker(selection: $branchOffice, label: Text("Branch office")) {
                    ForEach(BranchOffice.all, id: \.self) { office in
                        Text(office.name!)
                    }
                }
                Picker(selection: $vehicleType, label: Text("Vehicle type")) {
                    ForEach(VehicleType.allCases, id: \.self) { vehicle in
                        Text(vehicle.name)
                    }
                }
                Picker(selection: $engineType, label: Text("Engine type")) {
                    ForEach(EngineType.allCases, id: \.self) { engine in
                        Text(engine.name)
                    }
                }
            }
            
            Section {
                NavigationLink(destination: VehiclesListView(
                    branchOffice: branchOffice,
                    vehicleType: vehicleType,
                    engineType: engineType,
                    isRootActive: $isActive
                    ), isActive: self.$isActive
                ) {
                    Text("List vehicles").foregroundColor(Color.blue)
                }
                .isDetailLink(false)
            }
        }
        .navigationBarTitle("Select filters")
    }
}

struct VehicleFilterView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleFilterView()
    }
}
