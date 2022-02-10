//
//  LeftMenuView.swift
//  EquationSolver
//
//  Created by Joseph Jung on 2/9/22.
//  Copyright © 2022 Joseph Jung. All rights reserved.
//

import SwiftUI

struct LeftMenuView: View {
    @Binding var showAbout: Bool
    @Binding var showNewProblem: Bool
    @Binding var showVerification: Bool
    @Binding var showEquationView: Bool
    @Binding var neqText: String
    @Binding var showDocumentPicker: Bool
    @Binding var readFileContent: String
    @Binding var numEqsText: String
    @Binding var numEqs: Int
    
    
    @ObservedObject var equations: Equations
    @ObservedObject var system: Gauss
    
    var body: some View {
        VStack{
            
            
            // Mark: About
            
            Button("About"){
                showAbout = true
            }
            .sheet(isPresented: $showAbout) {
                AboutView(showAbout: self.$showAbout)
                    .onDisappear{
                        
                    }
            }
            .background(Color.red)
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
            
            
            
            //Mark: - New Problem
            Button(action:
                    {
                showNewProblem = true
                showEquationView = false
                
                
            }) {
                Text("Start New Problem")
            }
            .sheet(isPresented: $showNewProblem) {
                NewProblemView(neqText: $neqText, showNewProblem: $showNewProblem)
                
                    .onDisappear {
                        //                                    print("in Start New Problem")
                        
                        self.numEqsText = neqText
                        self.numEqs = Int(self.numEqsText) ?? 0
                        self.showEquationView = true
                        // Update the equations object
                        let tempEquations = Equations(neq: self.numEqs)
                        equations.copyElements(newObject: tempEquations)
                        
                        //
                        
                        // Update the system object
                        let tempGauss = Gauss(neq: self.numEqs)
                        system.copyElements(newObject: tempGauss)
                        
                        
                    }
            }
            .background(Color.red)
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
            
            //
            
            
            //Mark: - Read in File
            
            Button(action: {
                
                //                        print(" in Read file")
                
                showDocumentPicker = true
                showEquationView = false
                
                
            }) {
                Text("Load a Saved Problem")
            }
            .sheet(isPresented: self.$showDocumentPicker) {
                
                DocumentPicker(fileContent: $readFileContent)
                    .onDisappear {
                        
                        
                        //
                        
                        let decoder = JSONDecoder()
                        do {
                            
                            //                                    decode the data from the file
                            let readInData = try decoder.decode(Equations.self, from: (readFileContent).data(using: .utf8)!)
                            
                            
                            self.numEqsText = String(readInData.neq)
                            self.numEqs = readInData.neq
                            
                            //
                            //copy read object into current equation object
//                            let tempEquations = Equations(neq: self.numEqs) // temp new equation object
                            self.showEquationView = true
                            
//                            equations.copyElements(newObject: tempEquations)
                            
                            equations.copyElements(newObject: readInData)
                            
                            equations.blankXEText()
                            
                            //
                            
                            // Update the system object
                            let tempGauss = Gauss(neq: self.numEqs)
                            system.copyElements(newObject: tempGauss)
                            
                            
                            
                            //
                            
                        } catch {
                            print ("Error in decodeJSON")
                            system.solverMessage = "Invalid file selected"
                            showEquationView = true
                            //                                    message = "Error in decodeJSON while reading file"
                            //                                    showMessage = true
                            
                            return
                        }
                    }
                
            }
            .background(Color.red)
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
            
            
            
            
            
            //                   Mark: - Load Verification Problems
            
            
            Button("Verification Problems"){
                showVerification = true
                showEquationView = false
            }
            .sheet(isPresented: $showVerification) {
                VerificationProblemsView(showVerification: $showVerification, showEquationView: $showEquationView, equations: equations, system: system)
                
                    .onDisappear {
                        showVerification = false
                        showEquationView = true
                        
                    }
            }
            .background(Color.red)
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
            
            
            Spacer()
        } // VStack
    }
}

struct LeftMenuView_Previews: PreviewProvider {
    static var previews: some View {
        LeftMenuView(showAbout: .constant(true), showNewProblem: .constant(true), showVerification: .constant(true), showEquationView: .constant(true), neqText: .constant("2"), showDocumentPicker: .constant(true), readFileContent: .constant(" "), numEqsText: .constant("2"), numEqs: .constant(2), equations: Equations(neq: 2), system: Gauss(neq: 2))
    }
}
