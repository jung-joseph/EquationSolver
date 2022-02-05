//
//  Gauss.swift
//
//
//  Created by Joseph Jung on 4/23/20.
//

import Foundation


class Gauss: ObservableObject {
    
    var neq: Int
    var matrix = [[Double]]() // create an empty matrix
    var matrixCopy = [[Double]]()
    var bCopy = [Double]()
    
    @Published var x = [Double]()
    @Published var error = [Double]()
    @Published var solverMessage: String = ""
    @Published var errorText = [String]()
    
    init(neq: Int) {
        
        solverMessage = "Initializing a new system of \(neq) equations"
        self.neq = neq
        
        matrix = Array(repeating: Array(repeating: 0.0, count: neq+1), count: neq)
        matrixCopy = Array(repeating: Array(repeating: 0.0, count: neq+1), count: neq)
        bCopy = Array(repeating: 0.0, count: neq)
        
        x = Array(repeating: 0.0, count: neq)
        
        error = Array(repeating: 0.0, count: neq)
        errorText = Array(repeating: "0.0", count: neq)
        
        
        
        
    }
    
    //Mark: - Object copy
        func copyElements(newObject: Gauss) {
            
            self.neq = newObject.neq
            self.matrix = newObject.matrix
            self.matrixCopy = newObject.matrixCopy
            self.bCopy = newObject.bCopy
            self.x = newObject.x
            self.error = newObject.error
            self.solverMessage = newObject.solverMessage
            self.errorText = newObject.errorText
          
        }
    
    
    func printGaussObject(){
        print("Gauss Object")
        print("neq: \(neq)")
        self.printAMatrix()
        self.printMatrixCopy()
        self.printBVector()
        self.printBCopy()
        self.printX()
        self.printError()
        self.printErrorText()
        print("solver message \(self.solverMessage)")
        printX()
        
    }
    
    func printAMatrix() {
        print("The (augmented) A Matrix")
        
        for array in matrix {
            for value in array {
                print(value, terminator: " ")
            }
            print(" ")
        }
        

        print()
    }
    
    
    func printMatrixCopy() {
        print("Matrix Copy")
        
        for array in matrixCopy {
            for value in array {
                print(value, terminator: " ")
            }
            print(" ")
        }
        

        print()
    }
    func printBVector() {
        print("B Vector (of Augmented Matix)")
        for i in 0...neq - 1 {
            
            print(" \(matrix[i][neq])")
        }
        print()
    }
    
    func printBCopy() {
        print("The B Matrix Copy")
        
        for value in bCopy {
                print(value, terminator: " ")
            print(" ")
        }
        print()
    }
    
    func printX() {
        print("The X Matrix")
        
        for value in x {
                print(value, terminator: " ")
            print(" ")
        }
        print()
    }
    
    func printError() {
        print("The Error")
        
        for value in error {
                print(value, terminator: " ")
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
    
    
    @discardableResult func gaussSCPSolve() -> [Double] {
        // Gauss Elimination with Scaled Column Pivoting
        // Burden, Richard, Faires, J. Douglas, "Numerical Analysis", Third Ed., 1985
        
        var factor: Double
        
        var sum : Double
        var product : Double
        var nCopy: Int
        let smallNumber: Double = 1.0e-15
        var nRow:[Int] = Array(repeating: 0, count: neq)
        var s:[Double] = Array(repeating: 0.0, count: neq)
        
        
        // copy original matrix for later error calculations
        for i in 0..<neq {
            for j in 0..<neq {
                matrixCopy[i][j] = matrix[i][j]
            }
            bCopy[i] = matrix[i][neq]
        }
        
        
        // deal with only 1 equation
        if neq == 1 {
            if abs(matrix[0][0]) < smallNumber {
                x[0] = 0.0
                solverMessage = "Poorly Conditioned System: Zero or Near Zero Pivot"
                return x
            }
            x[0] = matrix[0][neq]/matrix[0][0]
            solverMessage = "Solution Found"
            return x
        }
        
        // Initialize Row Pointer
        
        for i in 0..<neq {
            s[i] = 0.0
            for j in 0..<neq {
                if abs(matrix[i][j]) > s[i] {
                    s[i] = abs(matrix[i][j])
                }
                
            }
            if s[i] == 0.0 {
                solverMessage = "No Unique Solution Exist: All Zeros in a Row"
                return x
            }
            nRow[i] = i
        }
        
        // Forward Elimination
        for i in 0...neq-2 {
            
            var p = i
            var maxInCol = abs(matrix[nRow[i]][i])/s[nRow[i]]
            
            for j in i..<neq {
                if abs(matrix[nRow[j]][i])/s[nRow[j]] > maxInCol {
                    p = j
                    maxInCol = abs(matrix[nRow[j]][i])
                }
            }
            
            if(maxInCol < smallNumber) {
                solverMessage = "No Unique Solution"
                return x
            }
            
            if(nRow[i] != nRow[p]) {
                nCopy = nRow[i]
                nRow[i] = nRow[p]
                nRow[p] = nCopy
            }
            
            
            for j in i+1...neq-1 {
                
                factor = matrix[nRow[j]][i]/matrix[nRow[i]][i]
                
                for jj in i...neq {
                    matrix[nRow[j]][jj] = matrix[nRow[j]][jj] - factor *  matrix[nRow[i]][jj]
                }
                
            }
            
        }
        
        if abs(matrix[nRow[neq-1]][neq-1]) < smallNumber {
            solverMessage = "No Unique Solution"
            return x
        }
        
        // Back Substituion
        
        x[neq-1] = matrix[nRow[neq-1]][neq]/matrix[nRow[neq-1]][neq-1]
        
        
        for i in stride(from: neq-2, through: 0, by: -1){
            sum = 0.0
            for j in i+1...neq-1 {
                product = matrix[nRow[i]][j] * x[j]
                sum = sum - product
            }
            x[i] = (matrix[nRow[i]][neq] + sum)/matrix[nRow[i]][i]
            
        }
        
        
        
        solverMessage = "Solution Found"
        return x
    }
    
    
    //Mark: - Gauss Elimination without pivoting
    
    @discardableResult func gaussSolve() -> [Double] {
        
        var factor: Double
        
        var sum : Double
        var product : Double
        let smallNumber: Double = 1.0e-15
        var nRow:[Int] = Array(repeating: 0, count: neq)
        var nCopy: Int
        
        // copy original matrix for later error calculations
        for i in 0..<neq {
            for j in 0..<neq {
//                print("gaussSolve \(i) \(j)")
                matrixCopy[i][j] = matrix[i][j]
            }
            bCopy[i] = matrix[i][neq]
        }
        
        // deal with only 1 equation
        if neq == 1 {
            if abs(matrix[0][0]) < smallNumber {
                x[0] = 0.0
                solverMessage = "Poorly Conditioned System: Zero or Near Zero Pivot"
                return x
            }
            x[0] = matrix[0][neq]/matrix[0][0]
            solverMessage = "Solution Found"
            return x
        }
        
        
        // Initialize Row Pointer
        
        for i in 0..<neq {
            nRow[i] = i
        }
        
        // Forward Elimination
       
            for i in 0...neq-2 {
                
                var p = -1
                for j in i..<neq {
                    //                for j in i..<neq {
                    
                    if abs(matrix[nRow[j]][i]) > smallNumber {
                        p = j
                        break
                    }
                }
                if(p == -1) {
                    solverMessage = "No Unique Solution or Possible Poorly Conditioned System"
                    return x
                }
                
                // Perform row interchange, if necessary
                if p != i {
//                    print("Gauss: interchanging rows \(p) for \(i)")
                    nCopy = nRow[i]
                    nRow[i] = nRow[p]
                    nRow[p] = nCopy
                }
                
                for j in i+1...neq-1 {
                    
                    if abs(matrix[nRow[i]][i]) < smallNumber {
                        solverMessage = "Poorly Conditioned System: Zero or Near Zero Pivot"
                        return x
                    }
                    factor = matrix[nRow[j]][i]/matrix[nRow[i]][i]
                    for jj in i...neq {
                        matrix[nRow[j]][jj] = matrix[nRow[j]][jj] - (factor *  matrix[nRow[i]][jj])
                    }
                    
                }
            }
            
            if abs(matrix[nRow[neq-1]][neq-1]) < smallNumber {
                solverMessage = "No Unique Solution: Zero in Last Pivot"
                return x
            }
        
        // Back Substituion
        
        x[neq-1] = matrix[nRow[neq-1]][neq]/matrix[nRow[neq-1]][neq-1]
        
        
            for i in stride(from: neq-2, through: 0, by: -1){
                sum = 0.0
                for j in i+1...neq-1 {
                    product = matrix[nRow[i]][j] * x[j]
                    sum = sum - product
                }
                x[i] = (matrix[nRow[i]][neq] + sum)/matrix[nRow[i]][i]
            }
        
        solverMessage = "Solution Found"
        return x
    }
    
    func printSolution(){
        print("Solution vector")
        print(" i   x[i]")
        
        for i in 0...neq-1 {
            print("\(i)     \(x[i])")
        }
    }
    func printSolverMessage(){
        print("\n\(solverMessage)\n")
    }
    
    @discardableResult func residual()-> [Double]  {
        
        
        for i in 0...neq - 1{
            error[i] = 0.0
            for j in 0..<neq {
                error[i] = error[i] + matrixCopy[i][j] * x[j]
            }
            error[i] = error[i] - bCopy[i]
        }
        
        return error
    }
    
    
}

