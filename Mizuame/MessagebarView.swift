//
//  MessagebarView.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/17.
//

import SwiftUI

struct MessagebarView: View {
    @AppStorage(SettingKeys.FontSize().key) private var fontSize: Int = SettingKeys.FontSize().initialValue

    @AppStorage(SettingKeys.MessageColor().keyR) private var msgR: Double = SettingKeys.MessageColor().initialR
    @AppStorage(SettingKeys.MessageColor().keyG) private var msgG: Double = SettingKeys.MessageColor().initialG
    @AppStorage(SettingKeys.MessageColor().keyB) private var msgB: Double = SettingKeys.MessageColor().initialB

    @AppStorage(SettingKeys.MessagebarColor().keyR) private var barR: Double = SettingKeys.MessagebarColor().initialR
    @AppStorage(SettingKeys.MessagebarColor().keyG) private var barG: Double = SettingKeys.MessagebarColor().initialG
    @AppStorage(SettingKeys.MessagebarColor().keyB) private var barB: Double = SettingKeys.MessagebarColor().initialB

    @Binding private var isShowFlag: Bool
    @Binding private var messageType: MessagebarEnum
    
    init(flag isShowFlag: Binding<Bool>, selected messageType: Binding<MessagebarEnum>) {
        _isShowFlag = isShowFlag
        _messageType = messageType
    }
    
    var body: some View {
        ZStack {
            Color(red: barR, green: barG, blue: barB)
            
            VStack(alignment: .leading) {
                Text(LocalizedStringKey(messageType.rawValue))
                    .font(.system(size: CGFloat(fontSize)))
                    .foregroundColor(Color(red: msgR, green: msgG, blue: msgB))
                
                HStack {
                    Spacer()
                    
                    if messageType != .DO_NOT_SAVE_JSON {
                        Button(action: {
                            messageType = .NONE
                            isShowFlag = false
                        }, label: {
                            Text("sitickynote.messagebar.action.button.cancel")
                                .font(.system(size: CGFloat(fontSize)))
                                .foregroundColor(Color(red: msgR, green: msgG, blue: msgB))
                        })
                        .buttonStyle(.borderless)
                    }

                    Button(action: {
                        isShowFlag = false
                    }, label: {
                        Text("sitickynote.messagebar.action.button.ok")
                            .bold()
                            .font(.system(size: CGFloat(fontSize)))
                            .foregroundColor(Color(red: msgR, green: msgG, blue: msgB))
                    })
                    .buttonStyle(.borderless)
                }
            }
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
        }
    }
}

struct MessagebarView_Previews: PreviewProvider {
    static var previews: some View {
        let localizations = ["en", "ja"]
        ForEach(localizations, id: \.self) { lang in
            MessagebarView(flag: .constant(true), selected: .constant(.QUIT))
                .previewDisplayName("lcal:\(lang)")
                .environment(\.locale, .init(identifier: lang))
        }
    }
}
