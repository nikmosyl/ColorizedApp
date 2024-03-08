//
//  ContentView.swift
//  ColorizedApp
//
//  Created by nikita on 05.03.24.
//

import SwiftUI

struct ContentView: View {
    @State private var red = Double.random(in: 0...255).rounded()
    @State private var green = Double.random(in: 0...255).rounded()
    @State private var blue = Double.random(in: 0...255).rounded()
    
    @FocusState private var isInputActive: Bool
    
    var body: some View {
        ZStack{
            VStack {
                ColorView(red: red, green: green, blue: blue)

                VStack {
                    ColorSliderView(sliderValue: $red, color: .red)
                    ColorSliderView(sliderValue: $green, color: .green)
                    ColorSliderView(sliderValue: $blue, color: .blue)
                }
                .frame(height: 150)
                .focused($isInputActive)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            isInputActive = false
                        }
                    }
                }
                
                Spacer()
            }
        }
        .padding()
        .onTapGesture {
            isInputActive = false
        }
    }
}

struct ColorView: View {
    
    let red: Double
    let green: Double
    let blue: Double
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(height: 150)
            .foregroundStyle(
                Color(
                    red: red/255,
                    green: green/255,
                    blue: blue/255
                )
            )
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 3))
    }
    
}

struct ColorSliderView: View {
    @Binding var sliderValue: Double
    let color: Color
    
    @State private var text = ""
    @State private var showAlert = false
    
    var body: some View {
        HStack {
            Text(sliderValue.formatted()).frame(width: 40)
            
            Slider(value: $sliderValue, in: 0...255, step: 1)
                .tint(color)
                .onChange(of: sliderValue) { _, newValue in
                    text = newValue.formatted()
                }
            
            TextFieldView(text: $text, action: checkValue)
                .alert("Wrong Format", isPresented: $showAlert, actions: {}) {
                    Text("Please enter value from 0 to 255")
                }
        }
        .onAppear {
            text = sliderValue.formatted()
        }
    }
    
    private func checkValue() {
        if let value = Double(text), (0...255).contains(value) {
            sliderValue = value
        } else {
            showAlert.toggle()
            sliderValue = 0
            text = "0"
        }
    }
}

struct TextFieldView: View {
    @Binding var text: String
    
    let action: () -> Void
    
    var body: some View {
        TextField("0", text: $text) {_ in
            withAnimation {
                action()
            }
        }
        .frame(width: 50, alignment: .trailing)
        .multilineTextAlignment(.trailing)
        .textFieldStyle(.roundedBorder)
        .keyboardType(.numberPad)
    }
}

#Preview {
    ContentView()
}
