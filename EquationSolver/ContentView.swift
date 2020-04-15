//
//  ContentView.swift
//  EquationSolver
//
//  Created by Joseph Jung on 4/14/20.
//  Copyright © 2020 Joseph Jung. All rights reserved.
//

import SwiftUI


struct Result {
    var id = UUID()
    var score: Int
}

struct ContentView: View {
    
    @State  var numEqs: Int = 2
    @State private var message: String = ""
    @ObservedObject var equations: Equations
    var neq: Int = 2
    
    let colors: [Color] = [.red, .green, .blue]
    let results = [Result(score: 8), Result(score: 5), Result(score: 10)]
    var data = [[1,2,3],[4,5,6],[7,8,9]]
    
    var body: some View {
        VStack{
            Text("Gauss Elimination Equation Solver").bold().foregroundColor(.blue).font(.system(size:40))
            HStack{
                Spacer()
                Text("Number of Equations: \(self.numEqs)")
//                equations = Gauss(neq: self.numEqs)
                Spacer()
                
                Button(action:
                {
                    self.message = "Adding Equation"
                    self.numEqs +=  1
//                    self.neq = self.neq + 1
                    
                }) {
                    Text("Add Equation")
                }.background(Color.red)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                
                Spacer()
                Button(action:
                {
                    self.message = "Subtracting Equation"
                    self.numEqs -= 1
                    if self.numEqs < 1 {
                        self.numEqs = 1
                    }

                }) {
                    Text("Remove Equation")
                }.background(Color.red)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                
                Spacer()
                Button(action:
                {
                    self.message = "Solving Equations"

                    var systemMatrix = Gauss(neq: self.numEqs)

                    
                }) {
                    Text("Solve Equations")
                }.background(Color.red)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                
                Spacer()

            }
            Text(message)
            Spacer()

            HStack{
                Group {
                    VStack{
                        
                        Text("A Matrix")
                        ForEach(equations.aMatrix, id: \.self) { array in
                            HStack{
                                ForEach(array, id: \.self) { element in
                                    
                                    Text("\(element)")
                                    
                                }
                            }
                            
                        }
                        
                    }
                    Group{
                        Text("*")
                    }
                    Group {

                        VStack {
                            Text("X Matrix")

                            ForEach(equations.xMatrix, id: \.self) { element in
                                Text("\(element)")
                            }
                        }
                        
                        
                    }
                    Group{
                        Text("=")
                    }
                    Group{
                        VStack {
                            Text("B Matrix")

                            ForEach(equations.bMatrix, id: \.self) { element in
                                Text("\(element)")
                            }
                        }
                    }
                }
            }
            Spacer()
            Spacer()
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(equations: Equations(neq: 2))
    }
}
