//
//  MessagebarView.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/17.
//

import SwiftUI

struct MessagebarView: View {
    @Binding private var isShowFlag: Bool
    @Binding private var messageType: MessagebarEnum
    
    private let fontSize: Int
    
    init(flag isShowFlag: Binding<Bool>, selected messageType: Binding<MessagebarEnum>, fontSize: Int = SettingKeys.FontSize().initialValue) {
        _isShowFlag = isShowFlag
        _messageType = messageType
        self.fontSize = fontSize
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(messageType.rawValue)
                .font(.system(size: CGFloat(fontSize)))
            
            HStack {
                Spacer()
                
                Button(action: {
                    isShowFlag = false
                }, label: {
                  Text("OK")
                        .font(.system(size: CGFloat(fontSize)))
                })
                .buttonStyle(.borderless)

                if messageType != .DO_NOT_SAVE_JSON {
                    Button(action: {
                        messageType = .NONE
                        isShowFlag = false
                    }, label: {
                        Text("Cancel")
                              .font(.system(size: CGFloat(fontSize)))
                    })
                    .buttonStyle(.borderless)
                }
            }
        }
        .padding(EdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5))
    }
}

struct MessagebarView_Previews: PreviewProvider {
    static var previews: some View {
        MessagebarView(flag: .constant(true), selected: .constant(.QUIT))
    }
}
