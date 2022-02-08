//
//  EquationsView.swift
//  EquationSolver
//
//  Created by Joseph Jung on 4/19/20.
//  Copyright © 2020 Joseph Jung. All rights reserved.
//

import SwiftUI

struct EquationsView: View {
    var numEqs: Int
    @ObservedObject var equations: Equations
    @ObservedObject var system: Gauss
    
    @State var showFileNamer = false
    @State var filename = ""
//    @State var operationMessage: String = ""
//    @State var showOperationMessage: Bool = false
    
    @Binding var showEquationView: Bool
    
    var body: some View {
        
        VStack{
            HStack{
                
                Group {  // A Matrix
                    VStack{
                        
                        Text("A")
                            .bold()
                        

                        
                        ForEach(0..<self.equations.aMatrixText.count){
                            let i = $0
                            
                            HStack{
                                
                                ForEach(0..<self.equations.neq) {
                                    let j = $0
                                    
                                    
                                    TextField(self.equations.aMatrixText[i][j], text: self.$equations.aMatrixText[i][j])
                                }
                            }
                            
                        }
                        
                    }
                }.textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 15)).fixedSize()
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
                
                Group {
                    
                    VStack { // X Matrix
                        Text("X")
                            .bold()
                        
                        ForEach(0..<self.equations.xMatrixText.count) {i in
//                            TextField(self.equations.xMatrixText[i], text: self.$equations.xMatrixText[i])
                            Text("\(self.equations.xMatrixText[i])")

                        }
                        .padding([.top, .bottom], 8)
                        .font(.custom("Arial", size: 15))
                        .fixedSize()
                    }
                    
                }.textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 15)).fixedSize()
                
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
                
                Group{
                    VStack { // B Matrix
                        Text("B ")
                            .bold()
                        
                        ForEach(0..<self.equations.bMatrixText.count) {i in
                            TextField(self.equations.bMatrixText[i], text: self.$equations.bMatrixText[i])
                            
                        }
                    }
                }.textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 15)).fixedSize()

                
   
                Group { // Error
                    VStack{
                        Text("Error")
                            .bold()
                        
                        ForEach(0..<self.system.error.count) { i in
                            
//                            TextField(self.system.errorText[i], text: self.$system.errorText[i] )
                            Text("\(self.equations.errorText[i])")
                                
                            
                        }
                        .padding([.top, .bottom], 8)
                        .font(.custom("Arial", size: 15))
                        .fixedSize()
                    }
                    
                    
                }
               
                
                

            } // HStack for Equations
            .keyboardType(.decimalPad)

            
            // solver message
//
                

                TextField("Solver Messages", text: self.$system.solverMessage)
            
            
            HStack {
                
                //Mark: - Gauss Elimination
                Button(action: {
                    
                    
// Fill in aMatrix from aMatrixText
                    showEquationView = false
                    
                    equations.blankXEText() // blank out x and error texts

                    
                    let errorCode = transferTextToDouble()
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
                        solutionToText()
                    }
                    
                    showEquationView = true
                    
                }) {
                    Text("Gauss Elimination")
                }.background(Color.green)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
                
                //Mark: - Gauss Elimination with Maximal Column Pivoting
                Button(action: {
                    
                    
// Fill in aMatrix from aMatrixText
                    showEquationView = false
                    
                    equations.blankXEText() // blank out x and error texts

                    
                    let errorCode = transferTextToDouble()
                    if errorCode {
                        system.solverMessage = "Invalid Entry"
                        self.showEquationView = true
                        return
                    }
                    
                    print(system.solverMessage)
                    

                    
                    let success = self.system.gaussMCPSolve()

                    
                    if success { // copy solution to Text
                        
                        system.residual()
                        solutionToText()
                    }
                    
                    showEquationView = true
                    
                }) {
                    Text("Gauss Elimination: Maximal Column Pivoting")
                }.background(Color.green)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
                
                
// Mark: Scaled Column Piviot
                Button(action: {

                    
                    showEquationView = false
                    
                    equations.blankXEText() // blank out x and error texts
                    
                    let errorCode = self.transferTextToDouble()
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
                        solutionToText()
                    }
                    showEquationView = true

                    
                }) {
                    Text("Gauss Elimination: Scaled Column-Pivot")
                }.background(Color.green)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
                
                VStack{
                //Mark: - Write File

                Button(action: {
                    
                    showFileNamer = true
                   
                        
                }) {
                    Text("Save the Current Problem")
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
                    .padding()
 //Mark: - Write Solution Vector
                
                Button {
                    showFileNamer = true
                } label: {
                    Text("Save the Current Solution")
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
                             writeTextFile( fileName: filename, contents: tempEncodedData)

        
                        }
                }
                .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
                }
                
            }

        } // View VStack
        
        
    }
    
    // Mark: - Functions to write text files
    
    @discardableResult func writeTextFile(fileName: String, contents: String) -> String {
        //
        // file name must have a .txt extension
        //
  
        
        let fileURL =   getDocumentsDirectory().appendingPathComponent(fileName)
        
        
        do {
            try contents.write(to: fileURL, atomically: true, encoding: .utf8)
            
            
            let input = try String(contentsOf: fileURL)
            print(input)
            
            return "Problem Saved"
        }
        catch{
            print("Error: \(error.localizedDescription)")
            return "Error: \(error.localizedDescription)"
        }
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    
    func transferTextToDouble() -> Bool{
        
//        let equations: Equations
//        var system: Gauss
        
//        print("In transferTextToDouble")
//        print("equations \(equations.neq)")
        for i in 0..<equations.neq {
            
            //Check that entries are Doubles
            if let value = (Double(equations.bMatrixText[i])) {
                self.system.matrix[i][equations.neq] = value
                
            } else {
                //
                return true
            }
            
            
            for j in 0..<equations.neq {
                
                
                
                //Check that entries are Doubles
                if let value = (Double(equations.aMatrixText[i][j])) {
                    system.matrix[i][j] = value
//                    print("i: \(i) j: \(j) matrixij: \(system.matrix[i][j])")
                } else {
                    //
                    return true
                }
                
                
                
            }
            
        }
        return false
    }
    
    func solutionToText() {
        for i in 0..<equations.neq {
            self.equations.xMatrixText[i] = String(format:"%.3e",self.system.x[i])
            self.equations.errorText[i] = String(format:"%.2e",self.system.error[i])
        }
    }
}

struct EquationsView_Previews: PreviewProvider {
    static var previews: some View {
        EquationsView(numEqs:2, equations: Equations(neq: 2), system: Gauss(neq: 2),showEquationView: .constant(true))
    }
}
