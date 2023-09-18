//
//  TermsOfServiceView.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/28.
//

import SwiftUI

struct TermsOfServiceView: View {
    @Binding var state: Int
    
    var body: some View {
        ZStack {
            Color("UserAgreementBackground")
            
            ScrollView {
                VStack {
                    TermsOfServiceBodyView()
                    
                    HStack {
                        Button(action: {
                            NSApplication.shared.terminate(self)
                        }, label: {
                            Text("agreement.common.quit")
                                .foregroundColor(.red)
                                .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                        })

                        Spacer()
                        
                        Button(action: {
                            state = SettingsViewState.PRIVACY_POLICY.rawValue
                        }, label: {
                            Text("agreement.common.agree")
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
        let localizations = ["en", "ja"]
        ForEach(localizations, id: \.self) { lang in
            TermsOfServiceView(state: .constant(0))
                    .previewDisplayName("lcal:\(lang)")
                    .environment(\.locale, .init(identifier: lang))
        }
    }
}
