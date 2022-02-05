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
            Text("New Problem")
            
            TextField("Enter the Number of Equations", text: $neqText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .font(.custom("Arial", size: 15)).fixedSize()
                .foregroundColor(isEditing ? Color.green : Color.black)
            
                .onSubmit {
                    self.isEditing = true
                }
                .onTapGesture {
                    self.isEditing = false
                }
            
            Button("Submit") {
                
                self.showNewProblem.toggle()
            }
            .background(Color.red)
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
        }
    }
}

struct NewProblemView_Previews: PreviewProvider {
    static var previews: some View {
        NewProblemView(neqText: .constant(""),showNewProblem: .constant(true))
    }
}
