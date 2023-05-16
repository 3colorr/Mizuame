//
//  ContentView.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/05/07.
//

import SwiftUI

struct ContentView: View {
    // This app not work when enable fetch request. why??
    // But, it may not be a feature that this app need.
    //@FetchRequest(something)
    
    @State private var stickyText: String = "abc"
    
    @State private var isErase: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "power")
                    .foregroundColor(Color.red)
                    .onTapGesture {
                        NSApplication.shared.terminate(self)
                    }
                
                Spacer()
                    .layoutPriority(1)
                
                Image(systemName: "eraser")
                    .onTapGesture {
                        isErase.toggle()
                    }
            }
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5))
            
            TextEditor(text: $stickyText)
                .layoutPriority(1)
        }
        .frame(width: 300, height: 150)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
