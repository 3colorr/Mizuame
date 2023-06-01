//
//  PrivacyPolicyBodyView.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/06/01.
//

import SwiftUI

struct PrivacyPolicyBodyView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Privacy Policy")
                .font(.title)
                .bold()
            
            Text("\"Mizuame (referred to as \"The Apps\")\" is owned by Akira Nakamura(3Colorr). (referred to as \"I\", \"Me\", \"Our\", \"We\", \"The Authors\" or \"Copyright holders\"). you are a \"User\" or \"You\" according to this policy.")

            Text("You can always review our Privacy Policy on the apps.")

            Text("Data and Privacy")
                .bold()

            Text("The Apps dose not collect any your data.")
            
            Text("I may know the user\'s email address when I receive a question from the user. The user\'s email address will only be used to reply to the user who asked the question.")
            
            Text("After answering the question, we delete the user\'s email address immediately. We never be shared information with third parties.")
            
            Text("If you do not agree, please uninstall The Apps.")
                .bold()
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        }
    }
}

struct PrivacyPolicyBodyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyBodyView()
    }
}
