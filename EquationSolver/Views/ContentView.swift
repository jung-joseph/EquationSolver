//
//  ContentView.swift
//  EquationSolver
//
//  Created by Joseph Jung on 4/14/20.
//  Copyright © 2020 Joseph Jung. All rights reserved.
//
//

import SwiftUI
import Foundation




struct ContentView: View {
    
    @State  var numEqs: Int
    @State var numEqsText: String = "-"
    @State var showEquationView = false
    
    @State private var readFileContent = ""
    @State var filename: String = ""
    @State private var showDocumentPicker = false
    @State private var showFileNamer = false
    @State private var showAbout = false
    @State private var showVerification = false
    
    @State var isEditing = false
    
    @State var showNewProblem = false
    @State var neqText = "2"
    
    //    var localEquations: Equations
    @ObservedObject var equations: Equations
    @ObservedObject var system: Gauss
    @ObservedObject var verificationProblems = VerificationProblems()
    
    
    
    
    
    var body: some View {
        ScrollView([.vertical,.horizontal]) {
            VStack{
                Text("Gauss Elimination Equation Solver").bold().foregroundColor(.blue).font(.system(size:40))
                
                
                HStack{
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
                            NewProblemView(neqText: self.$neqText, showNewProblem: self.$showNewProblem)
                            
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
                                        let tempEquations = Equations(neq: self.numEqs) // temp new equation object
                                        self.showEquationView = true
                                        
                                        equations.copyElements(newObject: tempEquations)
                                        
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
                    
                    //                Mark: Show EquationView
                    if(!self.showEquationView) {
                        Spacer()
                    }
                    
                    if(self.showEquationView) {
                        EquationsView(numEqs: self.numEqs, equations: equations, system: system, showEquationView: $showEquationView)
                        Spacer()
                    } else {
                        Spacer()
                    }
                }
                
                Spacer()
            }// VStack
            
        }// ScrollView
        
    }// body
    
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(numEqs: 2, numEqsText: "2",equations: Equations(neq: 2), system: Gauss(neq: 2))
    }
}
