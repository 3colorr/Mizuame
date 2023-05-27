//
//  TabInfo.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/05/25.
//

import SwiftUI

struct TabInfo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Mizuame").font(.title)
            Text("Version: 0.0.0").font(.body)
            Text("License: MIT license").font(.body)
            Text("Developed by: @3colorr").font(.body)
            Text("Terms Of Service: Something").font(.body)
            Text("Privacy Policy: Something").font(.body)
        }
        .padding(10)
    }
}

struct TabInfo_Previews: PreviewProvider {
    static var previews: some View {
        TabInfo()
    }
}
