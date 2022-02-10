//
//  SolveButtonSection.swift
//  EquationSolver
//
//  Created by Joseph Jung on 2/8/22.
//  Copyright © 2022 Joseph Jung. All rights reserved.
//

import SwiftUI

struct SolveButtonSection: View {
    @ObservedObject var equations: Equations
    @ObservedObject var system: Gauss
    @Binding var showFileNamer: Bool
    @Binding var filename: String
    @Binding var showEquationView: Bool
    
    var body: some View {
        VStack {

            HStack{
            Spacer()
//
            Text("Gauss Elimination Methods")
                .font(.title)
                .bold()
                .foregroundColor(.green)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 5))

            Spacer()
            Spacer()
            
        }
        HStack {
            
            //Mark: - Gauss Elimination
            Button(action: {
                
                
                showEquationView = false
                
                equations.blankXEText() // blank out x and error texts
                
                
                let errorCode = transferTextToDouble(equations: equations, system: system)
                if errorCode {
                    system.solverMessage = "Invalid Entry"
                    self.showEquationView = true
                    return
                }
                
                //                    print(system.solverMessage)
                
                
                
                let success = self.system.gaussSolve()
                //                    self.system.residual()
                
                if success { // copy solution to Text
                    system.residual()
                    solutionToText(equations: equations, system: system)
                }
                
                showEquationView = true
                
            }) {
                Text("Gauss Elimination (No Pivoting)")
            }.background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding()

            //Mark: - Gauss Elimination with Maximal Column Pivoting
            Button(action: {
                
                
                showEquationView = false
                
                equations.blankXEText() // blank out x and error texts
                
                
                let errorCode = transferTextToDouble(equations: equations, system: system)
                if errorCode {
                    system.solverMessage = "Invalid Entry"
                    self.showEquationView = true
                    return
                }
                
                print(system.solverMessage)
                
                
                
                let success = self.system.gaussMCPSolve()
                
                
                if success { // copy solution to Text
                    
                    system.residual()
                    solutionToText(equations: equations, system: system)
                }
                
                showEquationView = true
                
            }) {
                Text("Maximal Column Pivoting")
            }.background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding()
            
            
            // Mark: Scaled Column Piviot
            Button(action: {
                
                
                showEquationView = false
                
                equations.blankXEText() // blank out x and error texts
                
                let errorCode = transferTextToDouble(equations: equations, system: system)
                if errorCode {
                    system.solverMessage = "Invalid Entry"
                    self.showEquationView = true
                    return
                }
                //
                
                let success = self.system.gaussSCPSolve()
                
                //
                // write solution and error to Text
                if success { // copy solution to Text
                    system.residual()
                    solutionToText(equations: equations, system: system)
                }
                showEquationView = true
                
                
            }) {
                Text("Scaled Column-Pivot")
            }.background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding()
       
            VStack{
                
                
                //Mark: - Write File
                
                Button(action: {
                    
                    showFileNamer = true
                    filename = ""
                    
                }) {
                    Text("Save Problem")
                }
                .sheet(isPresented: $showFileNamer) {
                    
                    FileNamer(fileName: self.$filename, showFileNamer: self.$showFileNamer)
                    
                        .onDisappear {
                            let encodedData = try! JSONEncoder().encode(self.equations)
                            let tempEncodedData = String(data: encodedData, encoding: .utf8)!
                            print("in Write File")
                            print(tempEncodedData)
                            // Write to Files App
                            system.solverMessage = writeTextFile( fileName: filename, contents: tempEncodedData)
                        }
                }
                .background(Color.red)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding(EdgeInsets(top: 0, leading: 0, bottom:2, trailing: 5))
                
                
                
                
                //Mark: - Write Solution Vector
                
                Button {
                    showFileNamer = true
                    filename = ""

                } label: {
                    Text("Save Solution")
                }
                .sheet(isPresented: $showFileNamer) {
                    FileNamer(fileName: self.$filename, showFileNamer: self.$showFileNamer)
                    
                        .onDisappear {
                            var solutionVector = [Double]()
                            //                            print("self.numEqs \(self.numEqs)")
                            for i in 0..<equations.neq {
                                solutionVector.append(Double(self.equations.xMatrixText[i]) ?? 0.0)
                            }
                            //
                            
                            
                            let encodedData = try! JSONEncoder().encode(solutionVector)
                            let tempEncodedData = String(data: encodedData, encoding: .utf8)!
                            
                            //                             Write to Files App
                            system.solverMessage = writeTextFile( fileName: filename, contents: tempEncodedData)
                            
                            
                        }
                }
                .background(Color.red)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 5))
                
            } // VStack for save options
               
//
            
            
            
            } //HStack for solver buttons
            
        }// VStack for Solver action Title and Buttons
    }
}

struct SolveButtonSection_Previews: PreviewProvider {
    static var previews: some View {
        SolveButtonSection(equations: Equations(neq: 1), system: Gauss(neq: 1), showFileNamer: .constant(true), filename: .constant(""), showEquationView: .constant(true))
    }
}
