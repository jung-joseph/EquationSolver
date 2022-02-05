//
//  State.swift
//  EquationSolver
//
//  Created by Joseph Jung on 4/16/20.
//  Copyright © 2020 Joseph Jung. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class MatrixElement:  ObservableObject{
//    @Published var element: Double = 0.0
//    @State var elementState: Double = 0.0
    @State var elementState: Double = 0.0
//    var elementState: Double = 0.0
}

class MatrixElementStore: ObservableObject {
    
    @Published var aMatrix = [[MatrixElement]]()
    var elementState = MatrixElement()
    
    init(neq: Int) {
         aMatrix = Array(repeating: Array(repeating: elementState, count: neq), count: neq)
        
    }
}
