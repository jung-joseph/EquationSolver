//
//  Equations.swift
//  EquationSolver
//
//  Created by Joseph Jung on 4/15/20.
//  Copyright © 2020 Joseph Jung. All rights reserved.
//

import Foundation

class Equations: ObservableObject, Codable {
    @Published var aMatrix = [[Double]]() // create empty aMatrix
    @Published var xMatrix = [Double]() // create empty Solution Vector, xMatrix
    @Published var bMatrix = [Double]() // create empty Load Vector, bMatrix
    @Published var fillerStarVector = [String]() // filler vector for "*"
    @Published var fillerEqualVector = [String]()// filler vector for "="
    
    @Published var aMatrixText = [[String]]() // String array for aMatrix
    @Published var xMatrixText = [String]() // String array for xMatrix
    @Published var bMatrixText = [String]() // String array for bMatrix
    @Published var errorText = [String]() //
    @Published var neq: Int
    
    
    init(neq: Int) {
        
//        print("Creating an Equations Object with neq= \(neq)")
        
        self.neq = neq
        
        //        equations = Array(repeating: Array(repeating: 0.0, count: neq+1), count: neq)
        aMatrix = Array(repeating: Array(repeating: 0.0, count: neq), count: neq)
        aMatrixText = Array(repeating: Array(repeating: "0.0", count: neq), count: neq)
        
        xMatrix = Array(repeating: 0.0, count: neq)
        xMatrixText = Array(repeating: "-", count: neq)
        
        bMatrix = Array(repeating: 0.0, count: neq)
        bMatrixText = Array(repeating: "0.0", count: neq)
        
        fillerStarVector = Array(repeating: " ", count: neq/2)
        fillerEqualVector = Array(repeating: " ", count: neq/2)
        
        errorText = Array(repeating: "-", count: neq)

        
    }
    //Mark: - Codable
    enum CodingKeys: String, CodingKey {
        case neq
        
        case aMatrixText
        case xMatrixText
        case bMatrixText
        case errorText
        
        case aMatrix
        case xMatrix
        case bMatrix
        case fillerStarVector
        case fillerEqualVector
    }
    
// Mark: - Coadable
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        neq =        try values.decode(Int.self, forKey: .neq)
        
        aMatrixText = try values.decode([[String]].self, forKey: .aMatrixText)
        xMatrixText = try values.decode([String].self, forKey: .xMatrixText)
        bMatrixText = try values.decode([String].self, forKey: .bMatrixText)
        errorText = try values.decode([String].self, forKey: .errorText)
        
        aMatrix = try values.decode([[Double]].self, forKey: .aMatrix)
        xMatrix = try values.decode([Double].self, forKey: .xMatrix)
        bMatrix = try values.decode([Double].self, forKey: .bMatrix)

    }
    
//Mark: - Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(neq, forKey: .neq)

        try container.encode(aMatrixText, forKey: .aMatrixText)
        try container.encode(bMatrixText, forKey: .bMatrixText)
        try container.encode(xMatrixText, forKey: .xMatrixText)
        try container.encode(errorText, forKey: .errorText)
        
        try container.encode(aMatrix, forKey: .aMatrix)
        try container.encode(bMatrix, forKey: .bMatrix)
        try container.encode(xMatrix, forKey: .xMatrix)
    }
    
//Mark: - Object copy
    func copyElements(newObject: Equations) {
        
        self.neq = newObject.neq
        self.aMatrixText = newObject.aMatrixText
        self.bMatrixText = newObject.bMatrixText
        self.xMatrixText = newObject.xMatrixText
        self.errorText = newObject.errorText
        self.aMatrix = newObject.aMatrix
        self.bMatrix = newObject.bMatrix
        self.xMatrix = newObject.xMatrix
        self.fillerStarVector = newObject.fillerStarVector
        self.fillerEqualVector = newObject.fillerEqualVector
      
    }
    
    func printEquationsObject() {
        print("Equation Object")
        print("neq = ")
        print(self.neq)
        print()
        self.printAMatrixText()
        self.printXMatrixText()
        self.printBMatrixText()
        self.printErrorText()
        self.printAMatrix()
        self.printXMatrix()
        self.printBMatrix()
        print("fillerStarVector")
        print(fillerStarVector)
        print("fillerEqualVector")
        print(fillerEqualVector)
    }
    
    func printAMatrixText() {
        print("The A Matrix Text")
        
        for array in aMatrixText {
            for value in array {
                print(value, terminator: " ")
            }
            print(" ")
        }
        
        print()
    }
    
    func printErrorText() {
        print("The ErrorText")
        
        for value in errorText {
                print(value, terminator: " ")
            print(" ")
        }
        print()
    }
    
    func printAMatrix() {
        print("The A Matrix")
        
        for array in aMatrix {
            for value in array {
                print(value, terminator: " ")
            }
            print(" ")
        }
        
        print()
    }
    
    func printBMatrixText() {
        print("The B Matrix Text")
        
        for value in bMatrixText {
                print(value, terminator: " ")
            print(" ")
        }
        print()
    }
    
    func printBMatrix() {
        print("The B Matrix")
        
        for value in bMatrix {
                print(value, terminator: " ")
            print(" ")
        }
        print()
    }
    
    func printXMatrixText() {
        print("The X Matrix Text")
        
        for value in xMatrixText {
                print(value, terminator: " ")
            print(" ")
        }
        
        print()
    }
    
    func printXMatrix() {
        print("The X Matrix")
        
        for value in xMatrix {
                print(value, terminator: " ")
            print(" ")
        }
        
        print()
    }
    

    
    func adjust(newNeq: Int) {
        self.neq = newNeq
        let oldNeq = self.aMatrix.count
        
        var newRow = [Double]()
        var newRowText = [String]()
        
        //        construct the new row
        
        for _ in 0..<newNeq {
            newRow.append(0.0)
            newRowText.append("0.0")
        }
        print(newRow)
        //      fill in with the new row up to the number of old equations
        for i in 0..<oldNeq {
            self.aMatrix[i] = newRow
            self.aMatrixText[i] = newRowText
            
        }
        
        if(newNeq >= oldNeq) {
            
            for _ in oldNeq..<newNeq {
                self.aMatrix.append(newRow)
                self.aMatrixText.append(newRowText)
                
            }
        } else {
            for _ in newNeq..<oldNeq {
                self.aMatrix.removeLast()
                self.aMatrixText.removeLast()
                
            }
        }
        
        print("Leaving adjust aMatrixText.count is \(aMatrixText.count)")
        
    }
    //Mark: - Blank xMatrixText and errorText at the start of new problem, and after file read and copy
    func blankXEText() {
        for i in 0..<neq {
            xMatrixText[i] = "-"
            errorText[i] = "-"
        }
    }
}

