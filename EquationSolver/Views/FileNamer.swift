//
//  FileNamer.swift
//  FileManagerExample
//
//  Created by Joseph Jung on 1/27/22.
//

import SwiftUI

struct FileNamer: View {
    
    @Binding var fileName: String
    @Binding var showFileNamer: Bool
    
    var body: some View {
               
        VStack {
            Text("Save Current Problem or Solution")
                .foregroundColor(.blue)
                .font(.title)

            TextField("Enter File Name", text: $fileName)
                .foregroundColor(.black)
                .background(.white)
                .padding()
                .fixedSize()
                .colorScheme(.light)

            
            Button("Submit") {
                // check for .txt extension and add if missing
                let pathExtension = (fileName as NSString).pathExtension
                if pathExtension == "" {
                     fileName = fileName + ".txt"
                    print(fileName)
                }
                self.showFileNamer.toggle()
            }
            .background(Color.red)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding()
                
        }
    }
}

struct FileNamer_Previews: PreviewProvider {
    static var previews: some View {
        FileNamer(fileName: .constant(""),showFileNamer: .constant(true))
    }
}
