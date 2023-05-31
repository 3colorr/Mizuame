//
//  TabHelp.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/25.
//

import SwiftUI

struct TabHelp: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Hi.")
                    .bold()

                Text("I'm Mizuame, a sticky note app that sits in your Mac's menu bar. My favorite place is application folder. Someday I would like to go to Antarctica and have hot tomato soup.")

                Text("Attention")
                    .bold()

                Text("I'm NOT a high performance note app so that you should use other better apps to save your important data.")
                
                Text("Menu")
                    .bold()
                
                HStack {
                    Image(systemName: "power")
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                    Text("Power-off button.")
                }

                HStack {
                    Image(systemName: "gearshape.fill")
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                    Text("Open preference window.")
                }

                HStack {
                    Image(systemName: "eraser")
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                    Text("Deletes all sticky note contents.")
                }
                
                Spacer()
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        }
        .frame(width: 400, height: 300)
    }
}

struct TabHelp_Previews: PreviewProvider {
    static var previews: some View {
        TabHelp()
    }
}
