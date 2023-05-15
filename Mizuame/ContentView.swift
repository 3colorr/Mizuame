//
//  ContentView.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/05/07.
//

import SwiftUI

struct ContentView: View {
    @State private var dummyText: String = "aaa"
    
    var body: some View {
        VStack {
            Button(action: { NSApplication.shared.terminate(self) }) {
                Label("Quit", systemImage: "x.square.fill")
            }
            Text("Stickey")
            TextField("Stickey", text: $dummyText)
            HStack {
                Image(systemName: "pencil")
                Image(systemName: "eraser")
            }
            TextEditor(text: $dummyText)
        }
        .frame(width: 300, height: 150)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
