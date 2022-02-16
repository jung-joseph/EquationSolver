//
//  NewProblemView.swift
//  EquationSolver
//
//  Created by Joseph Jung on 1/29/22.
//  Copyright © 2022 Joseph Jung. All rights reserved.
//

import SwiftUI

struct NewProblemView: View {
    @Binding var neqText: String
    @Binding var showNewProblem: Bool


    
    @State var isEditing = false
    


    
    var body: some View {
        VStack {
            
            Text("Start A New Problem")
                .foregroundColor(Color.blue)
                .font(.title)
            
            HStack{
                Text("Number of Equations for a New Problem: ")
                    .foregroundColor(Color.black)
                TextField("  ", text: $neqText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .font(.custom("Arial", size: 15)).fixedSize()
                .foregroundColor(isEditing ? Color.green : Color.black)
                .colorScheme(.light)

            
                .onSubmit {
                    self.isEditing = true
                }
                .onTapGesture {
                    self.isEditing = false
                }
                
                Button("Submit") {
                    
                    self.showNewProblem = false
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

struct NewProblemView_Previews: PreviewProvider {
    static var previews: some View {
        NewProblemView(neqText: .constant(""), showNewProblem: .constant(true))
    }
}
