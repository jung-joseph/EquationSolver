//
//  DocumentPickerFiles.swift
//  EquationSolver
//
//  Created by Joseph Jung on 2/9/22.
//  Copyright © 2022 Joseph Jung. All rights reserved.
//

import Foundation
import SwiftUI
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
