//
//  TabPrint.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/07/09.
//

import SwiftUI

struct TabPrint: View {
    
    @AppStorage(SettingKeys.Printer().keyTopMargin) private var imageTopMargin: Int = SettingKeys.Printer().initialTopMargin
    @AppStorage(SettingKeys.Printer().keyBottomMargin) private var imageBottomMargin: Int = SettingKeys.Printer().initialBottomMargin
    @AppStorage(SettingKeys.Printer().keyLeftMargin) private var imageLeftMargin: Int = SettingKeys.Printer().initialLeftMargin
    @AppStorage(SettingKeys.Printer().keyRightMargin) private var imageRightMargin: Int = SettingKeys.Printer().initialRightMargin
    
    @AppStorage(SettingKeys.Printer().keyScalingFactor) private var imageScaling: Int = SettingKeys.Printer().initialScalingFactor
    
    @AppStorage(SettingKeys.Printer().keyVerticallyCentered) private var imageVerticallyCentered: Bool = SettingKeys.Printer().initialVerticallyCentered
    @AppStorage(SettingKeys.Printer().keyHorizontallyCentered) private var imageHorizontallyCentered: Bool = SettingKeys.Printer().initialHorizontallyCentered

    private let INIT_TOP_MARGIN: Int = SettingKeys.Printer().initialTopMargin
    private let INIT_BOTTOM_MARGIN: Int = SettingKeys.Printer().initialBottomMargin
    private let INIT_LEFT_MARGIN: Int = SettingKeys.Printer().initialLeftMargin
    private let INIT_RIGHT_MARGIN: Int = SettingKeys.Printer().initialRightMargin
    
    private let INIT_SCALING: Int = SettingKeys.Printer().initialScalingFactor
    
    private let INI_VERTICALLY_CENTERED: Bool = SettingKeys.Printer().initialVerticallyCentered
    private let INI_HORIZONTALLY_CENTERED: Bool = SettingKeys.Printer().initialHorizontallyCentered

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("settings.tab.print.greeting")

            VStack(alignment: .leading) {
                Text("settings.tab.print.margin")
                    .frame(width: 100, alignment: .leading)
                
                HStack {
                    Spacer()
                        .frame(width: 100, alignment: .leading)
                    
                    ZStack(alignment: .center) {
                        Rectangle()
                            .fill(Color("PrintMarginImageFill"))
                            .border(Color("PrintMarginImageBorder"))
                            .frame(width: 60, height: 80)
                        
                        Rectangle()
                            .stroke(Color("PrintMarginImageBorder"), style: StrokeStyle(lineWidth: 2, dash: [5, 5, 5, 5]))
                            .frame(width: 50, height: 70)
                        
                        VStack {
                            Text("settings.tab.print.margin.image.top")
                            Spacer()
                            Text("settings.tab.print.margin.image.bottom")
                        }
                        .padding(.vertical, 5)
                        
                        HStack {
                            Text("settings.tab.print.margin.image.left")
                            Spacer()
                            Text("settings.tab.print.margin.image.right")
                        }
                        .padding(.horizontal, 5)
                    }
                    .frame(width: 140, height: 130)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Spacer()
                            .frame(width: 100, alignment: .leading)
                        
                        Text("settings.tab.print.margin.top")
                            .frame(width: 50, alignment: .leading)
                        
                        TextField("\(INIT_TOP_MARGIN)", value: $imageTopMargin, formatter: NumberFormatter())
                            .frame(width: 50)
                            .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                    }
                    HStack {
                        Spacer()
                            .frame(width: 100, alignment: .leading)
                        
                        Text("settings.tab.print.margin.bottom")
                            .frame(width: 50, alignment: .leading)
                        
                        TextField("\(INIT_BOTTOM_MARGIN)", value: $imageBottomMargin, formatter: NumberFormatter())
                            .frame(width: 50)
                            .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                    }
                    HStack {
                        Spacer()
                            .frame(width: 100, alignment: .leading)
                        
                        Text("settings.tab.print.margin.left")
                            .frame(width: 50, alignment: .leading)
                        
                        TextField("\(INIT_LEFT_MARGIN)", value: $imageLeftMargin, formatter: NumberFormatter())
                            .frame(width: 50)
                            .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                    }
                    HStack {
                        Spacer()
                            .frame(width: 100, alignment: .leading)
                        
                        Text("settings.tab.print.margin.right")
                            .frame(width: 50, alignment: .leading)
                        
                        TextField("\(INIT_RIGHT_MARGIN)", value: $imageRightMargin, formatter: NumberFormatter())
                            .frame(width: 50)
                            .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                    }
                }
            }

            HStack {
                Text("settings.tab.print.scaling")
                    .frame(width: 100, alignment: .leading)

                TextField("\(INIT_SCALING)", value: $imageScaling, formatter: NumberFormatter())
                    .frame(width: 50)
                    .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
            }
            
            HStack {
                VStack {
                    Text("settings.tab.print.centered.title")
                    Spacer()
                }
                .frame(width: 100, alignment: .leading)
                
                VStack(alignment: .leading) {
                    Button(action: {
                        imageVerticallyCentered.toggle()
                    }, label: {
                        if imageVerticallyCentered {
                            Image(systemName: "checkmark.square.fill")
                        } else {
                            Image(systemName: "square")
                        }
                        
                        Text("settings.tab.print.centered.vertical").font(.body)
                    })
                    .buttonStyle(.plain)
                    
                    Button(action: {
                        imageHorizontallyCentered.toggle()
                    }, label: {
                        if imageHorizontallyCentered {
                            Image(systemName: "checkmark.square.fill")
                        } else {
                            Image(systemName: "square")
                        }
                        
                        Text("settings.tab.print.centered.horizontal").font(.body)
                    })
                    .buttonStyle(.plain)
                    
                    Spacer()
                }
            }
            
            Spacer()
            
            HStack {
                Text("settings.tab.print.reset.title")
                Button(action: {
                    self.imageTopMargin = INIT_TOP_MARGIN
                    self.imageBottomMargin = INIT_BOTTOM_MARGIN
                    self.imageLeftMargin = INIT_LEFT_MARGIN
                    self.imageRightMargin = INIT_RIGHT_MARGIN
                    self.imageScaling = INIT_SCALING
                    self.imageVerticallyCentered = INI_VERTICALLY_CENTERED
                    self.imageHorizontallyCentered = INI_HORIZONTALLY_CENTERED
                }) {
                    Text("settings.tab.print.reset.button.caption")
                        .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
                }
            }
        }
        .frame(width: 400, height: 500)
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
    }
}

struct TabPrint_Previews: PreviewProvider {
    static var previews: some View {
        let localizations = ["en", "ja"]
        ForEach(localizations, id: \.self) { lang in
            TabPrint()
                .previewDisplayName("lcal:\(lang)")
                .environment(\.locale, .init(identifier: lang))
        }
    }
}
