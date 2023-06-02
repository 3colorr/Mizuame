//
//  TermsOfServiceView.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/28.
//

import SwiftUI

struct TermsOfServiceView: View {
    @Binding var state: Int
    
    private let delegate = AppDelegate()

    var body: some View {
        ZStack {
            Color(.white)
            
            ScrollView {
                VStack {
                    TermsOfServiceBodyView()
                    
                    HStack {
                        Button(action: {
                            delegate.quitApp()
                        }, label: {
                            Text("Quit.")
                                .foregroundColor(.red)
                                .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                        })

                        Spacer()
                        
                        Button(action: {
                            state = SettingsViewState.PRIVACY_POLICY.rawValue
                        }, label: {
                            Text("I Agree.")
                                .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                        })
                    }
                }
                .font(.system(size: 15))
                .padding(20)
            }
            .frame(width: 400, height: 600)
        }
    }
}

struct TermsOfServiceView_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfServiceView(state: .constant(0))
    }
}
