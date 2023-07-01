//
//  ThemePalette.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/06/07.
//

import SwiftUI

struct ThemePalette: View {
    @Binding var message: String
    @Binding var messagebar: String
    @Binding var bodyForeground: String
    @Binding var bodyBackground: String
    @Binding var bodyFrame: String
    
    let lightMint = SettingKeys.ThemePalette.LightMint()
    let lightOrange = SettingKeys.ThemePalette.LightOrange()
    let lightBlue = SettingKeys.ThemePalette.LightBlue()
    let lightYellow = SettingKeys.ThemePalette.LightYellow()
    let MintMint = SettingKeys.ThemePalette.MintMint()
    let OrangeOrange = SettingKeys.ThemePalette.OrangeOrange()
    let BlueBlue = SettingKeys.ThemePalette.BlueBlue()
    let YellowYellow = SettingKeys.ThemePalette.YellowYellow()
    let whitePink = SettingKeys.ThemePalette.WhitePink()
    let whiteBlue = SettingKeys.ThemePalette.WhiteBlue()
    let whiteMint = SettingKeys.ThemePalette.WhiteMint()

    init(message: Binding<String>, messagebar: Binding<String>, bodyForeground: Binding<String>, bodyBackground: Binding<String>, bodyFrame: Binding<String>) {
        _message = message
        _messagebar = messagebar
        _bodyForeground = bodyForeground
        _bodyBackground = bodyBackground
        _bodyFrame = bodyFrame
    }
    
    var body: some View {
        VStack {
            
            VStack {
                HStack {
                    Button(action: {
                        message = lightMint.message
                        messagebar = lightMint.messagebar
                        bodyForeground = lightMint.foreground
                        bodyBackground = lightMint.background
                        bodyFrame = lightMint.frame
                        
                    }, label: {
                        if message == lightMint.message {
                            Image(systemName: "checkmark.square.fill")
                        } else {
                            Image(systemName: "square")
                        }
                        Text(lightMint.name).font(.body)
                    })
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    ColorBlocks(
                        bodyFrame: lightMint.frame,
                        messagebar: lightMint.messagebar,
                        message: lightMint.message,
                        bodyBackground: lightMint.background,
                        bodyForeground: lightMint.foreground)
                }
                
                HStack {
                    Button(action: {
                        message = lightOrange.message
                        messagebar = lightOrange.messagebar
                        bodyForeground = lightOrange.foreground
                        bodyBackground = lightOrange.background
                        bodyFrame = lightOrange.frame
                        
                    }, label: {
                        if message == lightOrange.message {
                            Image(systemName: "checkmark.square.fill")
                        } else {
                            Image(systemName: "square")
                        }
                        Text(lightOrange.name).font(.body)
                    })
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    ColorBlocks(
                        bodyFrame: lightOrange.frame,
                        messagebar: lightOrange.messagebar,
                        message: lightOrange.message,
                        bodyBackground: lightOrange.background,
                        bodyForeground: lightOrange.foreground)
                }
                
                HStack {
                    Button(action: {
                        message = lightBlue.message
                        messagebar = lightBlue.messagebar
                        bodyForeground = lightBlue.foreground
                        bodyBackground = lightBlue.background
                        bodyFrame = lightBlue.frame
                        
                    }, label: {
                        if message == lightBlue.message {
                            Image(systemName: "checkmark.square.fill")
                        } else {
                            Image(systemName: "square")
                        }
                        Text(lightBlue.name).font(.body)
                    })
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    ColorBlocks(
                        bodyFrame: lightBlue.frame,
                        messagebar: lightBlue.messagebar,
                        message: lightBlue.message,
                        bodyBackground: lightBlue.background,
                        bodyForeground: lightBlue.foreground)
                }
                
                HStack {
                    Button(action: {
                        message = lightYellow.message
                        messagebar = lightYellow.messagebar
                        bodyForeground = lightYellow.foreground
                        bodyBackground = lightYellow.background
                        bodyFrame = lightYellow.frame
                        
                    }, label: {
                        if message == lightYellow.message {
                            Image(systemName: "checkmark.square.fill")
                        } else {
                            Image(systemName: "square")
                        }
                        Text(lightYellow.name).font(.body)
                    })
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    ColorBlocks(
                        bodyFrame: lightYellow.frame,
                        messagebar: lightYellow.messagebar,
                        message: lightYellow.message,
                        bodyBackground: lightYellow.background,
                        bodyForeground: lightYellow.foreground)
                }
            }
            
            VStack {
                HStack {
                    Button(action: {
                        message = MintMint.message
                        messagebar = MintMint.messagebar
                        bodyForeground = MintMint.foreground
                        bodyBackground = MintMint.background
                        bodyFrame = MintMint.frame
                        
                    }, label: {
                        if message == MintMint.message {
                            Image(systemName: "checkmark.square.fill")
                        } else {
                            Image(systemName: "square")
                        }
                        Text(MintMint.name).font(.body)
                    })
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    ColorBlocks(
                        bodyFrame: MintMint.frame,
                        messagebar: MintMint.messagebar,
                        message: MintMint.message,
                        bodyBackground: MintMint.background,
                        bodyForeground: MintMint.foreground)
                }
                
                HStack {
                    Button(action: {
                        message = OrangeOrange.message
                        messagebar = OrangeOrange.messagebar
                        bodyForeground = OrangeOrange.foreground
                        bodyBackground = OrangeOrange.background
                        bodyFrame = OrangeOrange.frame
                        
                    }, label: {
                        if message == OrangeOrange.message {
                            Image(systemName: "checkmark.square.fill")
                        } else {
                            Image(systemName: "square")
                        }
                        Text(OrangeOrange.name).font(.body)
                    })
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    ColorBlocks(
                        bodyFrame: OrangeOrange.frame,
                        messagebar: OrangeOrange.messagebar,
                        message: OrangeOrange.message,
                        bodyBackground: OrangeOrange.background,
                        bodyForeground: OrangeOrange.foreground)
                }
                
                HStack {
                    Button(action: {
                        message = BlueBlue.message
                        messagebar = BlueBlue.messagebar
                        bodyForeground = BlueBlue.foreground
                        bodyBackground = BlueBlue.background
                        bodyFrame = BlueBlue.frame
                        
                    }, label: {
                        if message == BlueBlue.message {
                            Image(systemName: "checkmark.square.fill")
                        } else {
                            Image(systemName: "square")
                        }
                        Text(BlueBlue.name).font(.body)
                    })
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    ColorBlocks(
                        bodyFrame: BlueBlue.frame,
                        messagebar: BlueBlue.messagebar,
                        message: BlueBlue.message,
                        bodyBackground: BlueBlue.background,
                        bodyForeground: BlueBlue.foreground)
                }
                
                HStack {
                    Button(action: {
                        message = YellowYellow.message
                        messagebar = YellowYellow.messagebar
                        bodyForeground = YellowYellow.foreground
                        bodyBackground = YellowYellow.background
                        bodyFrame = YellowYellow.frame
                        
                    }, label: {
                        if message == YellowYellow.message {
                            Image(systemName: "checkmark.square.fill")
                        } else {
                            Image(systemName: "square")
                        }
                        Text(YellowYellow.name).font(.body)
                    })
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    ColorBlocks(
                        bodyFrame: YellowYellow.frame,
                        messagebar: YellowYellow.messagebar,
                        message: YellowYellow.message,
                        bodyBackground: YellowYellow.background,
                        bodyForeground: YellowYellow.foreground)
                }
            }
            
            VStack {
                HStack {
                    Button(action: {
                        message = whitePink.message
                        messagebar = whitePink.messagebar
                        bodyForeground = whitePink.foreground
                        bodyBackground = whitePink.background
                        bodyFrame = whitePink.frame

                    }, label: {
                        if message == whitePink.message {
                            Image(systemName: "checkmark.square.fill")
                        } else {
                            Image(systemName: "square")
                        }
                        Text(whitePink.name).font(.body)
                    })
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    ColorBlocks(
                        bodyFrame: whitePink.frame,
                        messagebar: whitePink.messagebar,
                        message: whitePink.message,
                        bodyBackground: whitePink.background,
                        bodyForeground: whitePink.foreground)
                }

                HStack {
                    Button(action: {
                        message = whiteBlue.message
                        messagebar = whiteBlue.messagebar
                        bodyForeground = whiteBlue.foreground
                        bodyBackground = whiteBlue.background
                        bodyFrame = whiteBlue.frame

                    }, label: {
                        if message == whiteBlue.message {
                            Image(systemName: "checkmark.square.fill")
                        } else {
                            Image(systemName: "square")
                        }
                        Text(whiteBlue.name).font(.body)
                    })
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    ColorBlocks(
                        bodyFrame: whiteBlue.frame,
                        messagebar: whiteBlue.messagebar,
                        message: whiteBlue.message,
                        bodyBackground: whiteBlue.background,
                        bodyForeground: whiteBlue.foreground)
                }

                HStack {
                    Button(action: {
                        message = whiteMint.message
                        messagebar = whiteMint.messagebar
                        bodyForeground = whiteMint.foreground
                        bodyBackground = whiteMint.background
                        bodyFrame = whiteMint.frame

                    }, label: {
                        if message == whiteMint.message {
                            Image(systemName: "checkmark.square.fill")
                        } else {
                            Image(systemName: "square")
                        }
                        Text(whiteMint.name).font(.body)
                    })
                    .buttonStyle(.plain)

                    Spacer()
                    
                    ColorBlocks(
                        bodyFrame: whiteMint.frame,
                        messagebar: whiteMint.messagebar,
                        message: whiteMint.message,
                        bodyBackground: whiteMint.background,
                        bodyForeground: whiteMint.foreground)
                }
            }
        }
    }
}

struct ColorBlocks: View {
    let bodyFrame: String
    let messagebar: String
    let message: String
    let bodyBackground: String
    let bodyForeground: String

    let w: CGFloat = 10
    let h: CGFloat = 10
    
    var body: some View {
        HStack {
            Rectangle()
                .fill(Color(bodyFrame))
                .frame(width: w, height: h)
            
            Rectangle()
                .fill(Color(messagebar))
                .frame(width: w, height: h)
            
            Rectangle()
                .fill(Color(message))
                .frame(width: w, height: h)
            
            Rectangle()
                .fill(Color(bodyBackground))
                .frame(width: w, height: h)
            
            Rectangle()
                .fill(Color(bodyForeground))
                .frame(width: w, height: h)
        }
    }
}

struct ThemePalette_Previews: PreviewProvider {
    static var previews: some View {
        ThemePalette(message: .constant("message"), messagebar: .constant("messagebar"), bodyForeground: .constant("foreground"), bodyBackground: .constant("background"), bodyFrame: .constant("frame"))
    }
}
