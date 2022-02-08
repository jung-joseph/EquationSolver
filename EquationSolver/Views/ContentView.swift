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
    @State var showEquationView = false
    
    @State private var readFileContent = ""
    @State var filename: String = ""
    @State private var showDocumentPicker = false
    @State private var showFileNamer = false
    @State private var showAbout = false
    @State private var showVerification = false

    @State var isEditing = false
    
    @State var showNewProblem = false
    @State var neqText = "2"
    
    //    var localEquations: Equations
    @ObservedObject var equations: Equations
    @ObservedObject var system: Gauss
    @ObservedObject var verificationProblems = VerificationProblems()

    
    
    
    
    var body: some View {
        VStack{
            Text("Gauss Elimination Equation Solver").bold().foregroundColor(.blue).font(.system(size:40))
            
            
            HStack{
                VStack{
                    // Mark: About
                    
                    Button("About"){
                        showAbout = true
                    }
                    .sheet(isPresented: $showAbout) {
                        AboutView()
                            .onDisappear{
                                
                            }
                    }
                    .background(Color.red)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding()
                   
                   
                    
                    
                    //Mark: - New Problem
                    Button(action:
                        {
                         showNewProblem = true
                        showEquationView = false

                            
                    }) {
                        Text("Start New Problem")
                    }
                        .sheet(isPresented: $showNewProblem) {
                            NewProblemView(neqText: self.$neqText, showNewProblem: self.$showNewProblem) 
                                
                                .onDisappear {
//                                    print("in Start New Problem")

                                    self.numEqsText = neqText
                                    self.numEqs = Int(self.numEqsText) ?? 0
                                    self.showEquationView = true
                                    // Update the equations object
                                    let tempEquations = Equations(neq: self.numEqs)
                                    equations.copyElements(newObject: tempEquations)
                                  
//
                                    
                                    // Update the system object
                                    let tempGauss = Gauss(neq: self.numEqs)
                                    system.copyElements(newObject: tempGauss)
                                    
                                                 
                                }
                        }
                        .background(Color.red)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                    
//
                        
                    
                    //Mark: - Read in File

                    Button(action: {
                        
//                        print(" in Read file")
                        
                        showDocumentPicker = true
                        showEquationView = false

                            
                    }) {
                        Text("Select a Previously Saved Problem")
                    }
                    .sheet(isPresented: self.$showDocumentPicker) {
                        
                        DocumentPicker(fileContent: $readFileContent)
                            .onDisappear {
                                

//
                                
                                let decoder = JSONDecoder()
                                do {
                                    
//                                    decode the data from the file
                                    let readInData = try decoder.decode(Equations.self, from: (readFileContent).data(using: .utf8)!)
                                    
                                    
                                    self.numEqsText = String(readInData.neq)
                                    self.numEqs = readInData.neq
                                    
//
                                    //copy read object into current equation object
                                    let tempEquations = Equations(neq: self.numEqs) // temp new equation object
                                    self.showEquationView = true

                                    equations.copyElements(newObject: tempEquations)
                                    
                                    equations.copyElements(newObject: readInData)
                                    
                                    equations.blankXEText()

//

                                    // Update the system object
                                    let tempGauss = Gauss(neq: self.numEqs)
                                    system.copyElements(newObject: tempGauss)



//

                                } catch {
                                    print ("Error in decodeJSON")
                                    system.solverMessage = "Invalid file selected"
                                    showEquationView = true
//                                    message = "Error in decodeJSON while reading file"
//                                    showMessage = true

                                    return
                                }
                            }

                    }
                    .background(Color.red)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding()
                
                    
                    
 
                
//                   Mark: - Load Verification Problems
                    
                    
                    Button("Verification Problems"){
                        showVerification = true
                        showEquationView = false
                    }
                    .sheet(isPresented: $showVerification) {
                        VerificationProblemsView(showVerification: $showVerification, showEquationView: $showEquationView, equations: equations, system: system)
                            
                            .onDisappear {
                                showVerification = false
                                showEquationView = true
            
                            }
                    }
                    .background(Color.red)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding()
                        
                } // VStack
                
//                Mark: Show EquationView
                if(!self.showEquationView) {
                    Spacer()
                }
                
                if(self.showEquationView) {
                    EquationsView(numEqs: self.numEqs, equations: equations, system: system, showEquationView: $showEquationView)
                    Spacer()
                } else {
                    Spacer()
                }
            }
            
            Spacer()
        }
        
    }// body
    
    // Mark: - Functions to write text files
    
    @discardableResult func writeTextFile(fileName: String, contents: String) -> String {
        //
        // file name must have a .txt extension
        //
  
        
        let fileURL =   getDocumentsDirectory().appendingPathComponent(fileName)
        
        
        do {
            try contents.write(to: fileURL, atomically: true, encoding: .utf8)
            
//  Read back to check that tile was written correctly
//            let input = try String(contentsOf: fileURL)
//            print(input)
            
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
    
    // Mark: - End write text files functions
   
    
    // Mark: - DocumentPicker files
    //
    struct DocumentPicker: UIViewControllerRepresentable {
        
        
        
        @Binding var fileContent: String
        
        func makeCoordinator() -> DocumentPickerCoordinator {
            return DocumentPickerCoordinator(fileContent: $fileContent)
        }
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController {
            
            //        let controller = UIDocumentPickerViewController(forOpeningContentTypes: [.text], asCopy: true)
            
            let controller = UIDocumentPickerViewController(forOpeningContentTypes: [.text])
            
            controller.delegate = context.coordinator
            
            return controller
        }
        
        //    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context){}
        func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>){}
        
    }
    
    
    
    class DocumentPickerCoordinator: NSObject, UIDocumentPickerDelegate, UINavigationControllerDelegate {
        
        @Binding var fileContent: String

        init(fileContent: Binding<String>) {
            _fileContent = fileContent
        }
        
        
        
        func documentPicker(_ controller: UIDocumentPickerViewController,
                            didPickDocumentsAt urls: [URL]) {
            let fileURL = urls[0]
            
            
            do {
                let _fileContent = try String(contentsOf: fileURL, encoding: .utf8)
//                print("In documentPicker - fileContent:")
//                print(_fileContent)
                // Perform Decode here
                
                self.fileContent = _fileContent // write to Binding to show in ContentView
            } catch {
                print(" An error occured reading file: \(error.localizedDescription)")
            }
            
        }
        
    }
    //Mark: - End DocumentPicker routines
    
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(numEqs: 2, numEqsText: "2",equations: Equations(neq: 2), system: Gauss(neq: 2))
    }
}
