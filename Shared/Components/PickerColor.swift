//
//  PickerColor.swift
//  TodoSwiftUI-tvOS
//
//  Created by Carlos Eduardo Umaña Acevedo on 6/8/23.
//

import SwiftUI

struct ColorItem: Hashable {
    let name: String
    let color: Color
}

struct PickerColor: View {
    @Binding var color: Color
    
    @State var openSelector = false
    
    private let colors = [
        ColorItem(name: "Red", color: .red),
        ColorItem(name: "Blue", color: .blue),
        ColorItem(name: "Orange", color: .orange),
        ColorItem(name: "Yellow", color: .yellow),
        ColorItem(name: "Purple", color: .purple),
        ColorItem(name: "Green", color: .green)
    ]
    
    var body: some View {
        #if os(watchOS) || os(tvOS)
        Button {
            openSelector.toggle()
        } label: {
            HStack {
                Text("Color")
                Spacer()
                Circle(color: color)
            }
        }
        .sheet(isPresented: $openSelector) {
            List {
                ForEach(colors, id: \.self) { item in
                    Button {
                        openSelector.toggle()
                        color = item.color
                    } label: {
                        HStack {
                            Circle(color: item.color)
                            Text(item.name)
                        }
                    }
                }
            }
        }
        #else
        ColorPicker("Color", selection: $color, supportsOpacity: false)
        #endif
    }
    
    func Circle(color: Color) -> some View {
        Image(systemName: "circle.fill")
            .frame(width: 20, height: 20)
            .foregroundColor(color)
    }
}

struct PickerColor_Previews: PreviewProvider {
    
    static var previews: some View {
        @State var color: Color = .red
        
        PickerColor(color: $color)
    }
}
