//
//  PrivacyPolicyView.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/05/28.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @Binding var state: Int
    
    //private let lisence: String = "https://www.apple.com/legal/privacy/data/ja/app-store/"
    private let lisence: String = "https://www.apple.com/legal/privacy/data/en/app-store/"
    
    var body: some View {
        ZStack {
            Color(.white)
            
            ScrollView {
                VStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Privacy Policy")
                            .font(.title)
                            .bold()
                        
                        Text("\"Mizuame (referred to as \"The Apps\")\" is owned by Akira Nakamura(3Colorr). (referred to as \"I\", \"Me\", \"Our\", \"We\", \"The Authors\" or \"Copyright holders\"). you are a \"User\" or \"You\" according to this policy.")

                        Text("You can always review our Privacy Policy on the apps.")

                        Text("Data and Privacy")
                            .bold()

                        Text("The Apps dose not collect any your data.")
                        
                        Text("I may know the user\'s email address or SNS acount when I receive a question from the user. The user\'s email address or SNS acount will only be used to reply to the user who asked the question.")
                        
                        Text("After answering the question, we delete information that the user\'s email address or SNS acount immediately. We never be shared information with third parties.")
                        
                        Text("If you do not agree, please uninstall The Apps.")
                            .bold()
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    }
                    
                    HStack {
                        Button(action: {
                            state = SettingsViewState.TERMS_OF_SERVICE.rawValue
                        }, label: {
                            Text("Back.")
                                .foregroundColor(.red)
                                .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                        })

                        Spacer()
                        
                        Button(action: {
                            state = SettingsViewState.PREFERENCE.rawValue
                        }, label: {
                            Text("I Agree.")
                                .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                        })
                    }
                }
                .font(.system(size: 15))
                .padding(20)
            }
            .frame(width: 400, height: 500)
        }
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView(state: .constant(1))
    }
}
