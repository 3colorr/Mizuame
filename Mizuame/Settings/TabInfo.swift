//
//  TabInfo.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/25.
//

import SwiftUI

struct TabInfo: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Mizuame").font(.title)
                Text("Version: 0.0.0").font(.body)
                Text("License: MIT license").font(.body)
                Text("Developed by: @3colorr").font(.body)
                Text("Terms Of Service: Something").font(.body)
                Text("Privacy Policy: Something").font(.body)
            }
        }
        .frame(width: 400, height: 200)
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
    }
}

struct TabInfo_Previews: PreviewProvider {
    static var previews: some View {
        TabInfo()
    }
}
