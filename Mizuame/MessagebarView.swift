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
    
    init(flag isShowFlag: Binding<Bool>, selected messageType: Binding<MessagebarEnum>) {
        _isShowFlag = isShowFlag
        _messageType = messageType
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(messageType.rawValue)
            HStack {
                Spacer()
                
                Button("OK") {
                    isShowFlag = false
                }
                .buttonStyle(.borderless)

                if messageType != .DO_NOT_SAVE_JSON {
                    Button("Cancel", role: .cancel) {
                        messageType = .NONE
                        isShowFlag = false
                    }
                    .buttonStyle(.borderless)
                }
            }
        }
    }
}

struct MessagebarView_Previews: PreviewProvider {
    static var previews: some View {
        MessagebarView(flag: .constant(true), selected: .constant(.QUIT))
    }
}
