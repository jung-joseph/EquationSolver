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
            
            EquationSection(equations: equations, system: system)
            
            // solver message
            //
            
            
            TextField("Solver Messages", text: self.$system.solverMessage)
            
            
            SolveButtonSection(equations: equations, system: system, showFileNamer: $showFileNamer, filename: $filename, showEquationView: $showEquationView)
           

            
        } // View VStack
        
        
    } // View

}

struct EquationsView_Previews: PreviewProvider {
    static var previews: some View {
        EquationsView(numEqs:2, equations: Equations(neq: 2), system: Gauss(neq: 2),showEquationView: .constant(true))
.previewInterfaceOrientation(.landscapeLeft)
    }
}

//Mark: - the following routines are at project scope

func solutionToText(equations: Equations, system: Gauss) {
    for i in 0..<equations.neq {
        equations.xMatrixText[i] = String(format:"%.3e",system.x[i])
        equations.errorText[i] = String(format:"%.2e",system.error[i])
    }
}


func transferTextToDouble(equations: Equations, system: Gauss) -> Bool{
    
    //        let equations: Equations
    //        var system: Gauss
    
    //        print("In transferTextToDouble")
    //        print("equations \(equations.neq)")
    for i in 0..<equations.neq {
        
        //Check that entries are Doubles
        if let value = (Double(equations.bMatrixText[i])) {
            system.matrix[i][equations.neq] = value
            
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
 
