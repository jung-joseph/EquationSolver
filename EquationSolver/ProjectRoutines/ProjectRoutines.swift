//
//  ProjectRoutines.swift
//  EquationSolver
//
//  Created by Joseph Jung on 2/9/22.
//  Copyright © 2022 Joseph Jung. All rights reserved.
//

import Foundation

//Mark: - the following routines are at project scope

func solutionToText(equations: Equations, system: Gauss, numSigFigs: String) {
    
    let numDecimalPlaces = Int(numSigFigs)! - 1
    
    for i in 0..<equations.neq {
        let negZeroX = String(format:"%.\(numDecimalPlaces)e",-0.0)
        let negZeroError = String(format:"%.2e",-0.0)
        
        // check for negative "-0.0"
        var xValue = String(format:"%.\(numDecimalPlaces)e",system.x[i])
        if String(format:"%.\(numDecimalPlaces)e",system.x[i]) == negZeroX {
             xValue = String(format:"%.\(numDecimalPlaces)e",0.0)
        }
        
        var eValue = String(format:"%.2e",system.error[i])
        if String(format:"%.3e",system.x[i]) == negZeroError {
             eValue = String(format:"%.2e",0.0)

        }
        
        equations.xMatrixText[i] = xValue
        equations.errorText[i] = eValue
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
        
        return "File Saved"
    }
    catch{
        print("Error: \(error.localizedDescription)")
        return "File Not Saved"
    }
}

 
 func getDocumentsDirectory() -> URL {
     // find all possible documents directories for this user
     let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
     
     // just send back the first one, which ought to be the only one
     return paths[0]
 }
 
