//
//  PrivacyPolicyBodyView.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/06/01.
//

import SwiftUI

struct PrivacyPolicyBodyView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("agreement.privacypolicy.title.main")
                .font(.title)
                .bold()
            
            Text("agreement.privacypolicy.define")

            Text("agreement.privacypolicy.views")

            Text("agreement.privacypolicy.title.privacy")
                .bold()

            Text("agreement.privacypolicy.privacy.data")
            
            Text("agreement.privacypolicy.privacy.email.purpose")
            
            Text("agreement.privacypolicy.privacy.email.action")
            
            Text("agreement.privacypolicy.confirm")
                .fixedSize(horizontal: false, vertical: true)
                .bold()
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        }
    }
}

struct PrivacyPolicyBodyView_Previews: PreviewProvider {
    static var previews: some View {
        let localizations = ["en", "ja"]
        ForEach(localizations, id: \.self) { lang in
            PrivacyPolicyBodyView()
                .previewDisplayName("lcal:\(lang)")
                .environment(\.locale, .init(identifier: lang))
        }
    }
}
