# EquationSolver/AX=B

"Welcome and Why"
"Welcome to AX=B! If you downloaded this app, I know that you are not a typical iOS user! Perhaps you have also noticed as I have, that there appears to be a dearth of BASIC \"Engineering or Science\" tools for students or professionals on the App Store. I have also observed that most college engineering programs (with the notable exception of computer science programs such as Stanford's), do not teach their students how to create programs (or tools) for mobile devices. Therefore, in the spirit of providing useful tools and programming examples of iOS tools for students, I created this simultaneous linear equation solver app. This app is written using SwiftUI (not UIKit). Once I am assured that the major bugs have been found and the app is reasonably easy to use, I intend to make the xCode project available in GitHub.  I hope that you find this app useful. "

"Usage"
"The actual app usage should be intuitive, but some guidance may be useful. The user may either initiate a completely new problem or read-in a problem that he/she had previously entered and saved. Saved problems and saved solutions are stored in Files App on iOS devices in JSON format. Once the problem has been entered (the coefficients of the A matrix and B vector are defined), any one of three solution algorithms may be used. All three algorithms are variants of Gauss elimination with back substituion (1). I included three algorithms to allow the user to explore how these variants perform for different types of problems. The algorithms are: Gauss Elimination with no row interchanges, Gauss Elimination with Maximal Column Pivoting, and Gauss Elimination with Scaled Column Pivoting. To assist the user in evaluating the performance of the different algorithms and the quality of the solution, an Error vector (the difference of each equation's B value and the computed result) is given. The users should always exam the values in the Error vector! In general, the Scaled Column Pivoting algorithm is considered be the most robust in working with poorly conditioned equation systems (1). The solution file may also be exported for subsequent use."

"Caution and Disclaimer"
"Of course, there cannot be a guarentee that any given numerical algorithm will always \"work.\"  Moreover, even though the implimentations have been extensively tested, I do not assume any responsibility for the results or the usage of the results of this software. The user is reminded to always exam the \"Error\" vector, as it provides a quantitative check of the accuracy of the numerical solution."

"References"
"1. Burden, Richard and Faires, J. Douglas; Numerical Analysis (third edition); Prindle, Weber & Schmit, Boston, 1985. "
"2. 3x3 Round-Off Verification Problem: https://www.rajgunesh.com/resources/downloads/numerical/gaussianelimination.pdf"

"Acknowledgment"
"A special word of appreciation for Dale Moseley is warranted. Dale's review comments helped to make this app much more robust and friendly."
