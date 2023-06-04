//
//  ColorSliderView.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/30.
//

import SwiftUI

struct ColorSliderView: View {
    let title: String
    
    @Binding var rr: Double
    @Binding var gg: Double
    @Binding var bb: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
            
            VStack {
                Slider(value: $rr, in: 0.0...1.0) {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 10, height: 10)
                }
                Slider(value: $gg, in: 0.0...1.0) {
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: 10, height: 10)
                }
                Slider(value: $bb, in: 0.0...1.0) {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 10, height: 10)
                }
            }
            .frame(width: 300)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        }
    }
}

struct ColorSliderView_Previews: PreviewProvider {
    static var previews: some View {
        ColorSliderView(title: "ColorSlider", rr: .constant(0.0), gg: .constant(0.0), bb: .constant(0.0))
    }
}
