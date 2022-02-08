//
//  VerificationProblemsView.swift
//  EquationSolver
//
//  Created by Joseph Jung on 2/7/22.
//  Copyright © 2022 Joseph Jung. All rights reserved.
//

import SwiftUI

struct VerificationProblemsView: View {
    
    @Binding var showVerification: Bool
    @Binding var showEquationView: Bool
    
    @ObservedObject var verificationProblems = VerificationProblems()
    @ObservedObject var equations: Equations
    @ObservedObject var system: Gauss
    
    var body: some View {
        VStack{
            Text("Verification and Example Problems")
                .bold()
                .foregroundColor(.blue)
                .font(.system(size:40))
            
            Spacer()
            HStack {
                VStack { //1x1
                    Button("Load Problem 1x1 #1 "){
                        let verificationProblem = verificationProblems.onexone
                        
                        decodeData(jsonInfile: verificationProblem!)
                        
                        self.showEquationView = false
                        self.showVerification = false
                    }
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
                    
                    Spacer()
                    Spacer()
                }
                VStack { //2x2
                    Button("Load Problem (2x2Idenity)"){
                        let verificationProblem = verificationProblems.idenity2x2
                        
                        decodeData(jsonInfile: verificationProblem)
                        
                        self.showEquationView = false
                        self.showVerification = false
                    }
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
                    
                    Button("Load Problem 2x2#1"){
                        let verificationProblem = verificationProblems.twoxtwo1
                        
                        decodeData(jsonInfile: verificationProblem!)
                        
                        self.showEquationView = false
                        self.showVerification = false
                    }
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
                    
                    Button("Load Problem 2x2#2"){
                        let verificationProblem = verificationProblems.twoxtwo2
                        
                        decodeData(jsonInfile: verificationProblem!)
                        
                        self.showEquationView = false
                        self.showVerification = false
                    }
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
                    
                    Spacer()
                    Spacer()
                }
                VStack { // 3x3
                    Button("Load Problem (3x3Idenity)"){
                        let verificationProblem = verificationProblems.idenity3x3
                        
                        decodeData(jsonInfile: verificationProblem!)
                        
                        self.showEquationView = false
                        self.showVerification = false
                    }
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
                    
                    Button("Load Problem 3x3#1 (NoSolution with Gauss)"){
                        let verificationProblem = verificationProblems.noSolutionGauss3x3
                        
                        decodeData(jsonInfile: verificationProblem!)
                        
                        self.showEquationView = false
                        self.showVerification = false
                    }
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
                    
                    
                    
                        Button("Load Problem 3x3#4 Round-Off Ref. 2"){
                            let verificationProblem = verificationProblems.threexthree4
                            
                            decodeData(jsonInfile: verificationProblem!)
                            
                            self.showEquationView = false
                            self.showVerification = false
                        }
                        .background(Color.red)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding()
                        
                    Spacer()
                    Spacer()
                }
                VStack { // 4x4
                    Button("Load Problem (4x4Idenity)"){
                        let verificationProblem = verificationProblems.idenity4x4
                        
                        decodeData(jsonInfile: verificationProblem!)
                        
                        self.showEquationView = false
                        self.showVerification = false
                    }
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
                    Button("Load Problem 4x4#1 (Gauss Failure/Round-Off 4x4)"){
                        let verificationProblem = verificationProblems.scp4x4
                        
                        decodeData(jsonInfile: verificationProblem!)
                        
                        
                        self.showEquationView = false
                        self.showVerification = false
                    }
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
                    Button("Load Problem 4x4#2 (NoSolution)"){
                        let verificationProblem = verificationProblems.noSolution4x4
                        
                        decodeData(jsonInfile: verificationProblem!)
                        
                        
                        self.showEquationView = false
                        self.showVerification = false
                    }
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
                    
                    Button("Load Problem 4x4#3"){
                        let verificationProblem = verificationProblems.fourbyfour
                        
                        decodeData(jsonInfile: verificationProblem!)
                        
                        
                        self.showEquationView = false
                        self.showVerification = false
                    }
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
                    
                    
                    
                    Spacer()
                    Spacer()
                }
                
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    @discardableResult func decodeData(jsonInfile: Data) -> Bool{
        
        var errorCode: Bool = false
        
        let decoder = JSONDecoder()
        do {
            
            //                                    decode the data from the file
            let decodedData = try decoder.decode(Equations.self, from: jsonInfile)
            
            
            //                let numEqsText = String(decodedData.neq)
            let numEqs = decodedData.neq
//            print("numEqs in decodeData: \(numEqs)")
            //
            //copy read object into current equation object
            let tempEquations = Equations(neq: numEqs) // temp new equation object
//            print("count of aMatrixText: \(tempEquations.aMatrixText.count)")
            equations.copyElements(newObject: tempEquations)
//            print("count of equations.aMatrixText: \(equations.aMatrixText.count)")

            equations.copyElements(newObject: decodedData)
//            print("count of equations.aMatrixText: \(equations.aMatrixText.count)")

            equations.blankXEText()
            
            //
            
            // Update the system object
            let tempGauss = Gauss(neq: numEqs)
            system.copyElements(newObject: tempGauss)
//            print("count of system.aMatrix: \(system.matrix.count)")
            
            
            
            //
            
        } catch {
            print ("Error in decodeJSON")
            system.solverMessage = "Invalid file selected"
            errorCode = true
            
            return errorCode
        }
        return errorCode
    }
}

struct VerificationProblemsView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationProblemsView( showVerification: .constant(true), showEquationView: .constant(true), equations: Equations(neq: 1), system: Gauss(neq: 1))
    }
}
