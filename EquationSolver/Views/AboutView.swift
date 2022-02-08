//
//  AboutView.swift
//  EquationSolver
//
//  Created by Joseph Jung on 2/6/22.
//  Copyright © 2022 Joseph Jung. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
//            HStack {
//                padding(EdgeInsets(top: 50, leading: 50, bottom: 50, trailing: 10))
//                Image("appGraphics")
//                    .resizable()
//                    .frame(width: 100, height: 100, alignment: .topLeading)
//                    .cornerRadius(10)
//                .border(Color.green, width: 2)
//
//                Spacer()
//            }
            
            HStack {
                Text("About")
                    .foregroundColor(Color.black)
                    .font(.largeTitle)
                    .bold()
                    .padding(EdgeInsets(top: 50, leading: 25, bottom: 0, trailing: 0))
                
                Image(systemName: "a.square.fill")
                    .resizable()
                    .frame(width: 75, height: 75, alignment: .topLeading)
                    .foregroundColor(.green)
                Image(systemName: "x.square.fill")
                    .resizable()
                    .frame(width: 75, height: 75, alignment: .topLeading)
                    .foregroundColor(.green)
                Image(systemName: "equal.square.fill")
                    .resizable()
                    .frame(width: 75, height: 75, alignment: .topLeading)
                    .foregroundColor(.green)
                Image(systemName: "b.square.fill")
                    .resizable()
                    .frame(width: 75, height: 75, alignment: .topLeading)
                    .foregroundColor(.green)
                
                
                Spacer()
            }
            
            VStack{
                Text("Welcome and Why")
                    .foregroundColor(Color.black)
                    .font(.title)
                    .padding(EdgeInsets(top: 25, leading: 25, bottom: 0, trailing: 0))
                Text("Welcome to EquationSolver! If you downloaded this app, I know that you are not a typical iOS user! Perhaps you have also noticed as I have, that there appears to be a dearth of BASIC \"Engineering or Science\" tools for students or professionals. I have also observed that most engineering programs (with the notable exception of computer science programs such as Stanford's), do not teach their students how to create programs (or tools) for mobile devices. Therefore, in the spirit of providing useful tools and programming examples of iOS tools for students, I created this simultaneous linear equation solver app. Once I am assured that the major bugs have been found and the app is reasonably easy to use, I intend to make the xCode project available in GitHub.  I hope that you find this app useful. ")
                    .font( Font.system(size: 15))
                    .foregroundColor(Color.black)

                
            }
            
            VStack{
                Text("Usage")
                    .foregroundColor(Color.black)
                    .font(.title)
                    .padding(EdgeInsets(top: 25, leading: 25, bottom: 0, trailing: 0))
                Text("The actual app usage should be intuitive, but some guidance may be useful. The user may either initiate a completely new problem or read in a problem that he/she had entered and previously saved. Previously saved problems are stored on the device in Files App. Once the problem has been entered (the coefficients of the A matrix and B vector are defined), any one of three solution algorithms may be used. All three algorithms are variants of Gauss elimination with back substituion (1). I included three algorithms to allow the user to explore how these variants perform for different types of problems. The algorithms are, Gauss Elimination with no row interchanges; Gauss Elimination with Maximal Column Pivoting; and Gauss Elimination with Scaled Column Pivoting. To assist the user to evaluate the performance of the different algorithms, an Error vector (the difference of each equation's B value and the computed result) is given. The users should always exam the values in the Error vector! Generally, the Scaled Column Pivoting algorithm is considered be the most robust against poorly conditioned equation systems and rounding error. (1)")
                    .font(Font.system(size: 15))
                    .foregroundColor(Color.black)


            }
            
            VStack{
                Text("Caution and Disclaimer")
                    .foregroundColor(Color.black)
                    .font(.title)
                    .padding(EdgeInsets(top: 25, leading: 25, bottom: 0, trailing: 0))
                Text("Of course, there cannot be a guarentee that any numerical algorithm will \"work.\"  Moreover, even though the implimentations have been extensively tested, I do not assume any responsibility for the results of the software or the usage of the results. ")
                    .font( Font.system(size: 15))
                    .foregroundColor(Color.black)
            }
            
            VStack{
                Text("Reference")
                    .foregroundColor(Color.black)
                    .font(.title)
                    .padding(EdgeInsets(top: 25, leading: 25, bottom: 0, trailing: 0))
                Text("1. Burden, Richard and Faires, J. Douglas; Numerical Analysis (third edition); Prindle, Weber & Schmit, Boston, 1985. ")
                    .font( Font.system(size: 15))
                    .foregroundColor(Color.black)
                Text("2. 3x3 Round-Off Verification Problem : https://www.rajgunesh.com/resources/downloads/numerical/gaussianelimination.pdf")

            }
            
        Spacer()
        Spacer()
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
