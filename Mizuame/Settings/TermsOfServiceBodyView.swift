//
//  TermsOfServiceBodyView.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/06/01.
//

import SwiftUI

struct TermsOfServiceBodyView: View {
    
    private let lisence: String = "https://github.com/3colorr/Mizuame/blob/main/LICENSE"

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Terms Of Service")
                .font(.title)
                .bold()
            
            Text("\"Mizuame (referred to as \"The Apps\")\" is owned by Akira Nakamura(3Colorr). (referred to as \"I\", \"Me\", \"Our\", \"We\", \"The Authors\" or \"Copyright holders\"). you are a \"User\" or \"You\" according to this agreement.")
            
            Text("Your access to and use of the Apps are conditioned on your acceptance of and compliance with these Terms. By accessing or using the Apps you agree to be bound by these Terms.")
            
            Text("You can always review our Terms of Service and Privacy Policy on the apps.")
            
            Text("About the use")
                .bold()
            
            Text("The Apps is open source software, under the MIT Lisence.")
            
            if let url = URL(string: lisence) {
                Link(lisence, destination: url)
            } else {
                Text(lisence)
            }

            Text("The Apps is free. Your use of the Apps is at your sole risk. The Apps is provided \"as is\", without warranty of any kind.")
            
            Text("In no event shall the authors or copyright holders be liable for any the software or the use or other dealings in the software.")
            
            Text("If you do not agree, please uninstall The Apps.")
                .bold()
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        }
    }
}

struct TermsOfServiceBodyView_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfServiceBodyView()
    }
}
