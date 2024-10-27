//
//  TabInfo.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/25.
//

import SwiftUI

struct TabInfo: View {
    @State private var isShowTermsOfService: Bool = false
    @State private var isShowPrivacyPolicy: Bool = false
    
    @State private var heightSize: CGFloat = 300
    private let initHeightSize: CGFloat = 300
    private let expandHeightSize: CGFloat = 500

    private let projectUrl: String = "https://github.com/3colorr/Mizuame"
    private let twUrl: String = "https://twitter.com/3colorr"
    private let websiteUrl: String = "https://3colorr.github.io/Mizuame-pages/"
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                HStack(alignment: .center) {
                    Image("MenubarIcon").font(.title)
                    Text("Mizuame").font(.title)
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Version: 1.3.0").font(.body)
                    Text("License: MIT license").font(.body)
                    HStack {
                        Text("settings.tab.info.src").font(.body)
                        if let url = URL(string: projectUrl) {
                            Link(projectUrl, destination: url)
                        } else {
                            Text(projectUrl)
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text("settings.tab.info.autor").font(.body)
                    Text("Email: 3colorr@gmail.com").font(.body)
                    HStack {
                        Text("X(Twitter):")
                        if let url = URL(string: twUrl) {
                            Link(twUrl, destination: url)
                        } else {
                            Text(twUrl)
                        }
                    }
                    HStack {
                        Text("Web:")
                        if let url = URL(string: websiteUrl) {
                            Link(websiteUrl, destination: url)
                        } else {
                            Text(websiteUrl)
                        }
                    }
                }

                Button(action: {
                    isShowTermsOfService.toggle()
                    isShowPrivacyPolicy = false
                    heightSize = expandHeightSize
                    
                    if !isShowTermsOfService && !isShowPrivacyPolicy {
                        heightSize = initHeightSize
                    }
                }) {
                    HStack(alignment: .center) {
                        if isShowTermsOfService {
                            Image(systemName: "checkmark.square.fill")
                        } else {
                            Image(systemName: "square")
                        }
                        Text("settings.tab.info.termsofservice.button.caption").font(.body)
                    }
                    .padding(EdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5))
                }

                Button(action: {
                    isShowPrivacyPolicy.toggle()
                    isShowTermsOfService = false
                    heightSize = expandHeightSize
                    
                    if !isShowTermsOfService && !isShowPrivacyPolicy {
                        heightSize = initHeightSize
                    }
                }) {
                    HStack(alignment: .center) {
                        if isShowPrivacyPolicy {
                            Image(systemName: "checkmark.square.fill")
                        } else {
                            Image(systemName: "square")
                        }
                        Text("settings.tab.info.privacypolicy.button.caption").font(.body)
                    }
                    .padding(EdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5))
                }

                if isShowTermsOfService {
                    TermsOfServiceBodyView()
                }
                
                if isShowPrivacyPolicy {
                    PrivacyPolicyBodyView()
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))

        }
        .frame(width: 400, height: heightSize)
    }
}

struct TabInfo_Previews: PreviewProvider {
    static var previews: some View {
        let localizations = ["en", "ja"]
        ForEach(localizations, id: \.self) { lang in
            TabInfo()
                .previewDisplayName("lcal:\(lang)")
                .environment(\.locale, .init(identifier: lang))
        }
    }
}
