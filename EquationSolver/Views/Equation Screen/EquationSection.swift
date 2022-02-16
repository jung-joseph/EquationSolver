//
//  EquationSection.swift
//  EquationSolver
//
//  Created by Joseph Jung on 2/8/22.
//  Copyright © 2022 Joseph Jung. All rights reserved.
//

import SwiftUI

struct EquationSection: View {
    @ObservedObject var equations: Equations
    @ObservedObject var system: Gauss
    @Binding var numSigFigs: String
    
    var body: some View {
       
            HStack{
//                MARK: - A Matrix
                Group {  // A Matrix
                    VStack{
                        
                        Text("A")
                            .bold()
                        
                        
                        
                        ForEach(0..<self.equations.aMatrixText.count){
                            let i = $0
                            
                            HStack{
                                
                                ForEach(0..<self.equations.neq) {
                                    let j = $0
                                    
                                    
                                    TextField(self.equations.aMatrixText[i][j], text: $equations.aMatrixText[i][j])
                                    // check for valid number here
                                    .foregroundColor(Double(self.equations.aMatrixText[i][j]) != nil ? Color.black : Color.red)
                                    .colorScheme(.light)

                                }
                            }
                            
                        }
                        
                    }
                }.textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 15)).fixedSize()
                
                
                //                MARK: - *

                Group{ // *
                    VStack{
                        Text("")
                        
                        ForEach(equations.fillerStarVector, id: \.self) { element in
                            Text("\(element)")
                        }
                        //                        Text("*")
                        Image(systemName: "multiply")
                            .resizable()
                            .frame(width: 10, height: 10)
                    }
                }
                
                
                //                MARK: - X Matrix

                Group {
                    
                    VStack { // X Matrix
                        Text("X")
                            .bold()
                        
                        ForEach(0..<self.equations.xMatrixText.count) {i in
                            Text("\(self.equations.xMatrixText[i])")
                            
                        }
                        .padding([.top, .bottom], 8)
                        .font(.custom("Arial", size: 15))
                        .fixedSize()
                    }
                    
                }
                

//                MARK: - =
                Group{ // =
                    VStack{ // =
                        Text("")
                        
                        ForEach(equations.fillerEqualVector, id: \.self) { element in
                            Text("\(element)")
                        }
                        //                        Text("=")
                        Image(systemName: "equal")
                            .resizable()
                            .frame(width: 10, height: 10)
                    }
                }
                
                
                //                MARK: - B Matrix

                Group{
                    VStack { // B Matrix
                        Text("B ")
                            .bold()
                        
                        ForEach(0..<self.equations.bMatrixText.count) {i in
                            TextField(self.equations.bMatrixText[i], text: self.$equations.bMatrixText[i])
                                .foregroundColor(Double(self.equations.bMatrixText[i]) != nil ? Color.black : Color.red)
                                .colorScheme(.light)


                        }
                    }
                }.textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 15)).fixedSize()
                
                
//  MARK: - Error
                Group { // Error
                    VStack{
                        Text("Error")
                            .bold()
                        
                        ForEach(0..<self.system.error.count) { i in
                            
                            Text("\(self.equations.errorText[i])")
                            
                            
                        }
                        .padding([.top, .bottom], 8)
                        .font(.custom("Arial", size: 15))
                        .fixedSize()
                    }
                    
                    
                }
                
                
                
                
            } // HStack for Equations
            .keyboardType(.numbersAndPunctuation)

      
    }
}



struct EquationSection_Previews: PreviewProvider {
    static var previews: some View {
        EquationSection(equations: Equations(neq: 1), system: Gauss(neq: 1), numSigFigs: .constant("4"))
    }
}
