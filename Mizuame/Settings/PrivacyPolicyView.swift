//
//  PrivacyPolicyView.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/28.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @Binding var state: Int
    
    var body: some View {
        ZStack {
            Color(.white)
            
            ScrollView {
                VStack {
                    PrivacyPolicyBodyView()
                    
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
