//
//  ContentView.swift
//  EquationSolver
//
//  Created by Joseph Jung on 4/14/20.
//  Copyright © 2020 Joseph Jung. All rights reserved.
//
//

import SwiftUI
import Foundation




struct ContentView: View {
    
    @State  var numEqs: Int
    @State var numEqsText: String = "-"
    @State var showEquationView = true
    
    @State private var readFileContent = ""
    @State var filename: String = ""
    @State private var showDocumentPicker = false
    @State private var showFileNamer = false
    @State private var showAbout = false
    @State private var showVerification = false
    @State private var showSettingsView = false
    @State private var numSigFigs = "4"
    
    @State var isEditing = false
    
    @State var showNewProblem = false
    @State var neqText = "2"
    
    //    var localEquations: Equations
    @ObservedObject var equations: Equations
    @ObservedObject var system: Gauss
    @ObservedObject var verificationProblems = VerificationProblems()
    
    
    
    
    
    var body: some View {
        
//        Background {

        ScrollView([.vertical,.horizontal]) {

            VStack{
                Text("Gauss Elimination Equation Solver").bold().foregroundColor(.blue).font(.system(size:40))
                
                
                HStack{
                    LeftMenuView(showAbout: $showAbout, showNewProblem: $showNewProblem, showVerification: $showVerification, showEquationView: $showEquationView, neqText: $neqText, showDocumentPicker: $showDocumentPicker, readFileContent: $readFileContent, numEqsText: $numEqsText, numEqs: $numEqs, showSettingsView: $showSettingsView, numSigFigs: $numSigFigs, equations: equations, system: system)

                    
                    //                Mark:  EquationView
                    
                    if(self.showEquationView) {
                        EquationsView(numEqs: self.numEqs, equations: equations, system: system, showEquationView: $showEquationView, numSigFigs: $numSigFigs)
                        Spacer()
                    } else {
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                }
                
                Spacer()
            }// VStack
        }// ScrollView

//            }// Background
        .onTapGesture {
            hideKeyboard()
        }

    }// body
    
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            ContentView(numEqs: 2, numEqsText: "2",equations: Equations(neq: 2), system: Gauss(neq: 2))
            .preferredColorScheme($0)
.previewInterfaceOrientation(.landscapeRight)
        }
    }
}
