//
//  Equations.swift
//  EquationSolver
//
//  Created by Joseph Jung on 4/15/20.
//  Copyright © 2020 Joseph Jung. All rights reserved.
//

import Foundation

class Equations: ObservableObject {
    var aMatrix = [[Double]]() // create empty aMatrix
    var xMatrix = [Double]() // create empty Solution Vector, xMatrix
    var bMatrix = [Double]() // create empty Load Vector, bMatrix
    var neq: Int
    
    
    init(neq: Int) {
        self.neq = 2
        
//        equations = Array(repeating: Array(repeating: 0.0, count: neq+1), count: neq)
        aMatrix = Array(repeating: Array(repeating: 0.0, count: neq), count: neq)
        xMatrix = Array(repeating: 0.0, count: neq)
        bMatrix = Array(repeating: 0.0, count: neq)

    }
}
