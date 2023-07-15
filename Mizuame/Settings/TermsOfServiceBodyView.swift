//
//  TermsOfServiceBodyView.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/06/01.
//

import SwiftUI

struct TermsOfServiceBodyView: View {
    
    private let lisence: String = "https://github.com/3colorr/Mizuame/blob/main/LICENSE"

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("agreement.termsofservice.title.main")
                .font(.title)
                .bold()
            
            Text("agreement.termsofservice.define")
            
            Text("agreement.termsofservice.consider")
            
            Text("agreement.termsofservice.views")
            
            Text("agreement.termsofservice.title.about")
                .bold()
            
            Text("agreement.termsofservice.lisence")
            
            if let url = URL(string: lisence) {
                Link(lisence, destination: url)
            } else {
                Text(lisence)
            }

            Text("agreement.termsofservice.blame")
            
            Text("agreement.termsofservice.disclaimer")
            
            Text("agreement.termsofservice.confirm")
                .fixedSize(horizontal: false, vertical: true)
                .bold()
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        }
    }
}

struct TermsOfServiceBodyView_Previews: PreviewProvider {
    static var previews: some View {
        let localizations = ["en", "ja"]
        ForEach(localizations, id: \.self) { lang in
            TermsOfServiceBodyView()
                .previewDisplayName("lcal:\(lang)")
                .environment(\.locale, .init(identifier: lang))
        }
    }
}
