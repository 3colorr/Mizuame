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
    private let expandHeightSize: CGFloat = 600

    private let src: String = "https://github.com/3colorr/Mizuame"
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                HStack(alignment: .center) {
                    Image(systemName: "text.bubble").font(.title)
                    Text("Mizuame").font(.title)
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Version: 0.0.0").font(.body)
                    Text("License: MIT license").font(.body)
                    HStack {
                        Text("Source code:").font(.body)
                        if let url = URL(string: src) {
                            Link(src, destination: url)
                        } else {
                            Text(src)
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text("Autor: Nakamura Akira").font(.body)
                    Text("Email: 3colorr@gmail.com").font(.body)
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
                        Text("Terms Of Service").font(.body)
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
                        Text("Privacy Policy").font(.body)
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
        TabInfo()
    }
}
