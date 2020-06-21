//
//  RentDateView.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 18/06/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import SwiftUI

struct RentDateView: View {
    var vehicle: Vehicle
    
    @Binding var isRootActive: Bool
    @Binding var isListActive: Bool
    
    private let firstDate = Calendar.current.startOfDay(for: Date())
    private let lastDate = Calendar.current.startOfDay(for: Date().addingTimeInterval(30 * 24 * 60 * 60))
    @State private var startDate = Calendar.current.startOfDay(for: Date())
    @State private var endDate = Calendar.current.startOfDay(for: Date())
    @State private var wrongDates = false
    @State private var showConfirmation = false
    @State private var reservationCode = ""
    @Environment(\.managedObjectContext) private var managedContext
    
    private func verifyDates() -> Bool {
        let availableDates = vehicle.getAvailableDates()
        for interval in availableDates {
            if interval.contains(startDate) && interval.contains(endDate) {
                return true
            }
        }
        
        return false
    }
    
    private func createReservation() -> String {
        let sampleClient = Customer.all[0]
        let reservationCode = sampleClient.bookVehicle(context: managedContext,
                                                       vehicle: vehicle,
                                                       startDate: startDate,
                                                       endDate: endDate)
        
        do {
            try managedContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return reservationCode
    }
    
    var body: some View {
        Form {
            Section {
                DatePicker("Start date", selection: $startDate, in: firstDate...lastDate, displayedComponents: .date)
                DatePicker("End date", selection: $endDate, in: startDate...lastDate, displayedComponents: .date)
            }
            
            Section {
                Button(action: {
                    if !self.verifyDates() {
                        self.wrongDates = true
                        return
                    }
                    
                    self.reservationCode = self.createReservation()
                    self.showConfirmation = true
                }) {
                    Text("Confirm").foregroundColor(Color.blue)
                }
                .alert(isPresented: $wrongDates, content: {
                    Alert(title: Text("Invalid dates"),
                          message: Text("The entered period is unavailable for booking."),
                          dismissButton: .cancel())
                })
                .sheet(isPresented: $showConfirmation) {
                    ConfirmationSheet(reservationCode: self.reservationCode,
                                      showingConfirmationView: self.$showConfirmation,
                                      isRootActive: self.$isRootActive,
                                      isListActive: self.$isListActive)
                }
                
                Button(action: {
                    self.isRootActive = false
                }) {
                    Text("Cancel").foregroundColor(.red)
                }
            }
        }
        .navigationBarTitle("Pick dates")
        .navigationBarBackButtonHidden(true)
    }
}

struct RentDateView_Previews: PreviewProvider {
    @State static var tmp = true
    
    static var previews: some View {
        RentDateView(vehicle: Vehicle.vehicles[0], isRootActive: $tmp, isListActive: $tmp)
    }
}
