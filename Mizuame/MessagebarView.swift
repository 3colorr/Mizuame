//
//  MessagebarView.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/17.
//

import SwiftUI

struct MessagebarView: View {
    @AppStorage(SettingKeys.FontSize().key) private var fontSize: Int = SettingKeys.FontSize().initialValue

    @AppStorage(SettingKeys.MessageColor().keyTheme) private var messageTheme: String = SettingKeys.MessageColor().initialTheme
    @AppStorage(SettingKeys.MessagebarColor().keyTheme) private var messagebarTheme: String = SettingKeys.MessagebarColor().initialTheme

    @Binding private var isShowFlag: Bool
    @Binding private var messageType: MessagebarEnum
    
    init(flag isShowFlag: Binding<Bool>, selected messageType: Binding<MessagebarEnum>) {
        _isShowFlag = isShowFlag
        _messageType = messageType
    }
    
    var body: some View {

        VStack(alignment: .leading) {
            Text(LocalizedStringKey(messageType.rawValue))
                .font(.system(size: CGFloat(fontSize)))
                .foregroundColor(Color(messageTheme))
            
            HStack {
                Spacer()
                
                if messageType != .DO_NOT_SAVE_JSON && messageType != .FAILED_IMPORT_JSON {
                    Button(action: {
                        messageType = .NONE
                        withAnimation {
                            isShowFlag = false
                        }
                    }, label: {
                        Text("sitickynote.messagebar.action.button.cancel")
                            .font(.system(size: CGFloat(fontSize)))
                            .foregroundColor(Color(messageTheme))
                    })
                    .buttonStyle(.borderless)
                }

                Button(action: {
                    withAnimation {
                        isShowFlag = false
                    }
                }, label: {
                    Text("sitickynote.messagebar.action.button.ok")
                        .bold()
                        .font(.system(size: CGFloat(fontSize)))
                        .foregroundColor(Color(messageTheme))
                })
                .buttonStyle(.borderless)
            }
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        .background(Color(messagebarTheme), in: RoundedRectangle(cornerRadius: 10))
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
