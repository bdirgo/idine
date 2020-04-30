//
//  CheckoutView.swift
//  iDine
//
//  Created by Benjamin Dirgo on 4/30/20.
//  Copyright © 2020 Benjamin Dirgo. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var order: Order

    static let paymentTypes = ["Cash", "Credit", "iDine"]
    static let tipAmounts = [10, 15, 20, 25, 0]
    
    @State private var tipAmount = 1
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var paymentType = 0
    @State private var showingPaymentAlert = false
    
    var totalPrice: Double {
        let total = Double(order.total)
        let tipValue = total / 100 * Double(Self.tipAmounts[tipAmount])
        return total + tipValue
    }

    var body: some View {
        Form {
            Section {
                Picker("How do you want to Pay?", selection: $paymentType) {
                    ForEach(0 ..< Self.paymentTypes.count) {
                        Text(Self.paymentTypes[$0])
                    }
                }
                
                Toggle(isOn: $addLoyaltyDetails.animation()) {
                    Text("Add iDine loyalty card")
                }
                
                if addLoyaltyDetails {
                    TextField("Enter your iDine ID:", text: $loyaltyNumber)
                }
                
                Section(header: Text("Add a tip?")) {
                    Picker("Percentage:", selection: $tipAmount) {
                        ForEach(0 ..< Self.tipAmounts.count) {
                            Text("\(Self.tipAmounts[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total: $\(totalPrice, specifier: "%.2f")").font(.largeTitle)) {
                    Button("Confirm Order") {
                        self.showingPaymentAlert.toggle()
                    }
                }
            }
        }
        .navigationBarTitle(Text("Payment"), displayMode: .inline)
        .alert(isPresented: $showingPaymentAlert) {
            Alert(title: Text("Order Confirmed"), message: Text("Your total is $\(totalPrice, specifier: "%.2f") - Thank you!"), dismissButton: .default(Text("OK")))
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static let order = Order()
    static var previews: some View {
        NavigationView {
            CheckoutView().environmentObject(order)
        }
    }
}
