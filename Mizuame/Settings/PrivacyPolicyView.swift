//
//  PrivacyPolicyView.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/28.
//

import SwiftUI

struct PrivacyPolicyView: View {

    @AppStorage(SettingKeys.FontSize().key) private var fontSize: Int = SettingKeys.FontSize().initialValue

    @Binding var state: Int
    
    var body: some View {
        ZStack {
            Color("UserAgreementBackground")
            
            ScrollView {
                VStack {
                    PrivacyPolicyBodyView()
                    
                    HStack {
                        Button(action: {
                            state = SettingsViewState.TERMS_OF_SERVICE.rawValue
                        }, label: {
                            Text("agreement.common.back")
                                .foregroundColor(.red)
                                .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                        })

                        Spacer()
                        
                        Button(action: {
                            state = SettingsViewState.PREFERENCE.rawValue
                        }, label: {
                            Text("agreement.common.agree")
                                .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                        })
                    }
                }
                .font(.system(size: CGFloat(fontSize)))
                .padding(20)
            }
            .frame(width: 400, height: 500)
        }
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        let localizations = ["en", "ja"]
        ForEach(localizations, id: \.self) { lang in
            PrivacyPolicyView(state: .constant(1))
                .previewDisplayName("lcal:\(lang)")
                .environment(\.locale, .init(identifier: lang))
        }
    }
}
