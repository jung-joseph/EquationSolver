//
//  SettingsView.swift
//  EquationSolver
//
//  Created by Joseph Jung on 2/13/22.
//  Copyright © 2022 Joseph Jung. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var numSigFigs: String
    @Binding var showSettingsView: Bool
    
    var body: some View {
        VStack {
            Text("Settings")
                .foregroundColor(Color.blue)
                .font(.title)
            
            HStack{
                Text("Number of Significant Figures in Solution Display: ")
                    .foregroundColor(Color.black)
                TextField("  ", text: $numSigFigs)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .font(.custom("Arial", size: 15)).fixedSize()
                    .foregroundColor(Color.black)
                    
                
                Button("Submit") {
                    self.showSettingsView = false
                    // check for validity of numSigFig and make sure it is >= 2
                    if let numDigits = Int(numSigFigs){
                        if numDigits > 1 {
                            return
                        } else {
                            numSigFigs = "2"
                        }
                    } else {
                        numSigFigs = "4"
                    }
                    
                   
                }
                .background(Color.red)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding()
            }
        }
        .keyboardType(.decimalPad)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(numSigFigs: .constant("3"), showSettingsView: .constant(true))
    }
}
