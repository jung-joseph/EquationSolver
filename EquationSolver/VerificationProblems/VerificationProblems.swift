//
//  VerificationProblems.swift
//  EquationSolver
//
//  Created by Joseph Jung on 2/6/22.
//  Copyright © 2022 Joseph Jung. All rights reserved.
//

import Foundation

class VerificationProblems: ObservableObject {
    
   @Published var idenity2x2 = """
{"bMatrixText":["1.0","1.0"],"bMatrix":[0,0],"aMatrix":[[0,0],[0,0]],"xMatrix":[0,0],"xMatrixText":["-","-"],"errorText":["-","-"],"neq":2,"aMatrixText":[["1.0","0.0"],["0.0","1.0"]]}
""".data(using: .utf8)!

@Published var noSolution4x4 = """
{"bMatrixText":["7.0","5.0","10.0","0.0"],"bMatrix":[0,0,0,0],"aMatrix":[[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]],"xMatrix":[0,0,0,0],"xMatrixText":["-","-","-","-"],"errorText":["-","-","-","-"],"neq":4,"aMatrixText":[["1.0","1.0","1.0","1.0"],["1.0","1.0","0.0","2.0"],["2.0","2.0","3.0","0.0"],["-1.0","-1.0","-2.0","2.0"]]}
""".data(using: .utf8)

    @Published var noSolutionGauss3x3 = """
{"bMatrixText":["5.0","4.0","6.0"],"bMatrix":[0,0,0],"aMatrix":[[0,0,0],[0,0,0],[0,0,0]],"xMatrix":[0,0,0],"xMatrixText":["-","-","-"],"errorText":["-","-","-"],"neq":3,"aMatrixText":[["1.0","-2.0","1.0"],["-1.0","2.0","1.0"],["3.0","-2.0","0.0"]]}
""".data(using: .utf8)
    
    @Published var noSolutions4x4 = """
{"bMatrixText":["2.0","1.0","0.0","-3.0"],"bMatrix":[0,0,0,0],"aMatrix":[[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]],"xMatrix":[0,0,0,0],"xMatrixText":["-","-","-","-"],"errorText":["-","-","-","-"],"neq":4,"aMatrixText":[["1.0","1.0","0.0","1.0"],["2.0","1.0","-1.0","1.0"],["4.0","-1.0","-2.0","2.0"],["3.0","-1.0","-1.0","2.0"]]}
""".data(using: .utf8)
    
    @Published var scp4x4 = """
{"bMatrixText":["2.0","1.0","4.0","-3.0"],"bMatrix":[0,0,0,0],"aMatrix":[[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]],"xMatrix":[0,0,0,0],"xMatrixText":["-","-","-","-"],"errorText":["-","-","-","-"],"neq":4,"aMatrixText":[["1.0","1.0","0.0","1.0"],["2.0","1.0","-1.0","1.0"],["-1.0","2.0","3.0","-1.0"],["3.0","-1.0","-1.0","2.0"]]}
""".data(using: .utf8)
    
    @Published var onexone = """
{"bMatrixText":["1000.0"],"bMatrix":[0],"aMatrix":[[0]],"xMatrix":[0],"xMatrixText":["-"],"errorText":["-"],"neq":1,"aMatrixText":[["100.0"]]}
""".data(using: .utf8)
    
    @Published var twoxtwo1 = """
{"bMatrixText":["3.0","4.0"],"bMatrix":[0,0],"aMatrix":[[0,0],[0,0]],"xMatrix":[0,0],"xMatrixText":["-","-"],"errorText":["-","-"],"neq":2,"aMatrixText":[["1.0","-2.0"],["2.0","1.0"]]}
""".data(using: .utf8)
    
    @Published var twoxtwo2 = """
{"bMatrixText":["7.0","5.0"],"bMatrix":[0,0],"aMatrix":[[0,0],[0,0]],"xMatrix":[0,0],"xMatrixText":["-","-"],"errorText":["-","-"],"neq":2,"aMatrixText":[["2.0","-3.0"],["1.0","2.0"]]}
""".data(using: .utf8)
    
    @Published var threexthree4 = """
    {"bMatrixText":["61.3","0.0","83.7"],"bMatrix":[0,0,0],"aMatrix":[[0,0,0],[0,0,0],[0,0,0]],"xMatrix":[0,0,0],"xMatrixText":["-","-","-"],"errorText":["-","-","-"],"neq":3,"aMatrixText":[["0.007","61.20","0.093"],["4.81","-5.92","1.110"],["81.400","1.12","1.18"]]}
""".data(using: .utf8)
    
    @Published var idenity3x3 = """
    {"bMatrixText":["1.0","1.0","1.0"],"bMatrix":[0,0,0],"aMatrix":[[0,0,0],[0,0,0],[0,0,0]],"xMatrix":[0,0,0],"xMatrixText":["-","-","-"],"neq":3,"aMatrixText":[["1.0","0.0","0.0"],["0.0","1.0","0.0"],["0.0","0.0","1.0"]],"errorText":["-","-","-"]}
""".data(using: .utf8)
    
    @Published var idenity4x4 = """
    {"bMatrixText":["1.0","1.0","1.0","1.0"],"bMatrix":[0,0,0,0],"aMatrix":[[0,0,0,0],[0,0,0,0],[0,0,0,0]],"xMatrix":[0,0,0,0],"xMatrixText":["-","-","-","-"],"neq":4,"aMatrixText":[["1.0","0.0","0.0","0.0"],["0.0","1.0","0.0","0.0"],["0.0","0.0","1.0","0.0"],["0.0","0.0","0.0","1.0"]],"errorText":["-","-","-","-"]}
""".data(using: .utf8)

    @Published var fourbyfour = """
    {"bMatrixText":["5.94","14.07","8.52","7.59"],"bMatrix":[0,0,0,0],"aMatrix":[[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]],"xMatrix":[0,0,0,0],"xMatrixText":["-","-","-","-"],"neq":4,"aMatrixText":[["4.01","1.23","1.43","-0.73"],["1.23","7.41","2.41","3.02"],["1.43","2.41","5.79","-1.11"],["-0.73","3.02","-1.11","6.41"]],"errorText":["-","-","-","-"]}
""".data(using: .utf8)

}
