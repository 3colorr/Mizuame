//
//  MessagebarView.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/05/17.
//

import SwiftUI

struct MessagebarView: View {
    @Binding var isShowFlag: Bool
    @Binding var messageType: MessagebarEnum
    
    var body: some View {
        VStack {
            Text(messageType.rawValue)
            HStack {
                Spacer()
                Text("OK")
                Text("Cancel")
            }
        }
    }
}

struct MessagebarView_Previews: PreviewProvider {
    static var previews: some View {
        MessagebarView(isShowFlag: .constant(true), messageType: .constant(.QUIT))
    }
}
