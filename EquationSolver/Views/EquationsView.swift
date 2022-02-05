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
                            Text("\(self.system.errorText[i])")
                                
                            
                        }
                        .padding([.top, .bottom], 8)
                        .font(.custom("Arial", size: 15))
                        .fixedSize()
                    }
                    
                    
                }
               
                
//                .textFieldStyle(RoundedBorderTextFieldStyle()).padding().font(.custom("Arial", size: 15)).fixedSize()
                
                
            } // HStack for Equations
            
            HStack{
                Spacer()
                Spacer()
                TextField("Solver Messages", text: self.$system.solverMessage)
            }
            
            HStack {
                
                //Mark: - Gauss Elimination
                Button(action: {
                    
                    
                    // Fill in aMatrix from aMatrixText
                    for i in 0..<self.numEqs {
                        self.system.matrix[i][self.numEqs] = Double(self.equations.bMatrixText[i]) ?? 0.0
                        for j in 0..<self.numEqs {
//                            print("i \(i)  j \(j)  \(self.equations.aMatrixText[i][j])")
                            self.system.matrix[i][j] = Double(self.equations.aMatrixText[i][j]) ?? 0.0
                        }
                    }
                    
//                    self.equations.printEquationsObject()
                    
                    self.system.gaussSolve()
                    self.system.residual()

                    for i in 0..<self.numEqs {
                        self.equations.xMatrixText[i] = String(format:"%.3e",self.system.x[i])
                        self.system.errorText[i] = String(format:"%.2e",self.system.error[i])

                    }
                    //                    self.system.printSolution()
                    //                systemMatrix.printAMatrix()
                    //                systemMatrix.printBVector()
                    
                }) {
                    Text("Gauss Elimination Solve")
                }.background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
                
                
                
                // Mark: Scaled Column Piviot
                Button(action: {
//                                           print("in Scaled Column Pivot Solve Button")
                     
                     for i in 0..<self.numEqs {
                         self.system.matrix[i][self.numEqs] = Double(self.equations.bMatrixText[i]) ?? 0.0
                         for j in 0..<self.numEqs {
//                             print("i \(i)  j \(j)  \(self.equations.aMatrixText[i][j])")
                             self.system.matrix[i][j] = Double(self.equations.aMatrixText[i][j]) ?? 0.0
                         }
                     }
                     
//                    self.equations.printEquationsObject()
                    self.system.gaussSCPSolve()
                    self.system.residual()

                    for i in 0..<self.numEqs {
                        self.equations.xMatrixText[i] = String(format:"%.3e",self.system.x[i])
                        self.system.errorText[i] = String(format:"%.2e",self.system.error[i])
                    }
//                    self.system.printSolution()
//                    self.system.printError()
                }) {
                    Text("Scaled Column-Pivot Elimination Solve")
                }.background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
                
 //Mark: - Write Solution Vector
                
                Button {
                    showFileNamer = true
                } label: {
                    Text("Write Solution to File")
                }
                .sheet(isPresented: $showFileNamer) {
                    FileNamer(fileName: self.$filename, showFileNamer: self.$showFileNamer)
                        
                        .onDisappear {
                            var solutionVector = [Double]()
//                            print("self.numEqs \(self.numEqs)")
                            for i in 0..<self.numEqs {
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
            print("In writeTextFiles")
            let input = try String(contentsOf: fileURL)
            print(input)
            
            return "File Saved"
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
    
}

//struct EquationsView_Previews: PreviewProvider {
//    static var previews: some View {
//        EquationsView(showEquationView: true, equations: Equations(neq: 2))
//    }
//}
