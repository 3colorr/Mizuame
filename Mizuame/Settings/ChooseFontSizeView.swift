//
//  ChooseFontSizeView.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2024/12/31.
//

import SwiftUI

struct ChooseFontSizeView: View {
    
    @AppStorage(SettingKeys.FontSize().key) private var fontSize: Int = SettingKeys.FontSize().initialValue
    
    @State var chooseFontSize: Int = SettingKeys.FontSize().initialValue
    @State var pickerFontSize: Int = SettingKeys.FontSize().initialValue
    @State var isPickerFontSize: Bool = true
    @State var isNotifyMessage: Bool = false
    
    @Binding var state: Int
    
    let sampleFontSizeArray: [Int] = [14, 17, 20]
    var body: some View {
        ZStack {
            Color("UserAgreementBackground")

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    Text("launch.fontsize.introduction")
                        .font(.title)

                    ForEach(sampleFontSizeArray, id: \.self) { sampleFontSize in
                        ChooseButtonView(chooseFontSize: $chooseFontSize, sampleFontSize: sampleFontSize, isPickerFontSize: $isPickerFontSize, isNotifyMessage: $isNotifyMessage)
                    }

                    HStack {
                        Button(action: {
                            chooseFontSize = pickerFontSize
                            isPickerFontSize = true
                            isNotifyMessage = false
                        }, label: {
                            if isPickerFontSize && chooseFontSize == pickerFontSize {
                                Image(systemName: "checkmark.square.fill")
                                    .foregroundColor(Color.accentColor)
                            } else {
                                Image(systemName: "square")
                            }
                        })
                        .buttonStyle(.plain)

                        VStack(alignment: .leading) {
                            Text("launch.fontsize.check")
                            HStack {
                                Text("settings.tab.stickynote.font.size")
                                
                                Picker("", selection: $pickerFontSize) {
                                    ForEach(1..<41, id: \.self) { num in
                                        Text("\(num)")
                                    }
                                }
                                .frame(width: 60)
                            }
                        }
                        .font(.system(size: CGFloat(pickerFontSize)))
                    }

                    Spacer()

                    Text("launch.fontsize.info")
                        .font(.title2)

                    if isNotifyMessage {
                        Text("launch.fontsize.notify")
                            .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
                            .font(.title2)
                            .background(Color.accentColor)
                            .foregroundStyle(.white)
                    }

                    HStack() {
                        Spacer()
                        Button(action: {
                            if chooseFontSize != pickerFontSize
                                && sampleFontSizeArray.contains(chooseFontSize) == false {
                                
                                isNotifyMessage = true
                                
                            } else {
                                self.fontSize = chooseFontSize
                                state = SettingsViewState.TERMS_OF_SERVICE.rawValue
                            }
                        }, label: {
                            Text("launch.common.next")
                                .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                        })
                    }
                }
                .font(.system(size: 15))
                .padding(20)
            }
        }
        .frame(width: 400, height: 430)
    }
}

struct ChooseButtonView: View {
    
    @Binding var chooseFontSize: Int
    let sampleFontSize: Int
    
    @Binding var isPickerFontSize: Bool
    @Binding var isNotifyMessage: Bool

    init(chooseFontSize: Binding<Int>, sampleFontSize: Int, isPickerFontSize: Binding<Bool>, isNotifyMessage: Binding<Bool>) {
        self._chooseFontSize = chooseFontSize
        self.sampleFontSize = sampleFontSize
        self._isPickerFontSize = isPickerFontSize
        self._isNotifyMessage = isNotifyMessage
    }

    var body: some View {
        HStack {
            Button(action: {
                chooseFontSize = sampleFontSize
                isPickerFontSize = false
                isNotifyMessage = false
            }, label: {
                if isPickerFontSize == false && chooseFontSize == sampleFontSize {
                    Image(systemName: "checkmark.square.fill")
                        .foregroundColor(Color.accentColor)
                } else {
                    Image(systemName: "square")
                }
            })
            .buttonStyle(.plain)

            VStack(alignment: .leading) {
                Text("launch.fontsize.check")
                
                HStack {
                    Text("settings.tab.stickynote.font.size")
                    Text("\(sampleFontSize)")
                }
            }
            .font(.system(size: CGFloat(sampleFontSize)))
        }
    }
}

#Preview("ja") {
    ChooseFontSizeView(state: .constant(0))
        .environment(\.locale, .init(identifier: "ja"))
}

#Preview("en") {
    ChooseFontSizeView(state: .constant(0))
        .environment(\.locale, .init(identifier: "en"))
}
