//
//  ContentView.swift
//  ColorizedApp
//
//  Created by nikita on 05.03.24.
//

import SwiftUI

struct ContentView: View {
    @State private var redComponent = Double.random(in: 0...255)
    @State private var greenComponent = Double.random(in: 0...255)
    @State private var blueComponent = Double.random(in: 0...255)
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 150)
                .foregroundStyle(
                    Color(
                        red: redComponent/255,
                        green: greenComponent/255,
                        blue: blueComponent/255
                    )
                )
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 3))
            Spacer().frame(height: 50)
            ColorSliderView(sliderValue: $redComponent, color: .red)
            ColorSliderView(sliderValue: $greenComponent, color: .green)
            ColorSliderView(sliderValue: $blueComponent, color: .blue)
            Spacer()
        }
        .padding()
    }
}

struct ColorSliderView: View {
    @Binding var sliderValue: Double
    
    let color: Color
    
    var body: some View {
        HStack {
            Text(lround(sliderValue).formatted()).frame(width: 40)
            Slider(value: $sliderValue, in: 0...255, step: 1)
                .tint(color)
        }
    }
}

#Preview {
    ContentView()
}
