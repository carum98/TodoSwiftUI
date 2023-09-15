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
    
    let items = [
        ["#f43b30", "Red"],
        ["#e71f56", "Rose"],
        ["#9c27b0", "Purple"],
        ["#673ab7", "Blue"],
        ["#3f51b5", "Royal Blue"],
        ["#5677fc", "Periwinkle"],
        ["#03a9f4", "Light Blue"],
        ["#00bcd4", "Cyan"],
        ["#009688", "Teal"],
        ["#259b24", "Green"],
        ["#8bc34a", "Lime Green"],
        ["#cddc39", "Lime"],
        ["#ffeb3b", "Yellow"],
        ["#ffc107", "Amber"],
        ["#ff9800", "Orange"],
        ["#ff5722", "Deep Orange"],
        ["#795548", "Brown"],
        ["#607d8b", "Blue Grey"],
        ["#9e9e9e", "Grey"],
    ].map { ColorItem(name: $0.last!, color: Color(hex: $0.first!)) }
    
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
                    ForEach(items, id: \.self) { item in
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
        Grid {
            GridRow {
                ForEach(items[0..<5], id: \.self) { item in
                    ColorSquare(value: item.color)
                }
            }
            GridRow {
                ForEach(items[5..<10], id: \.self) { item in
                    ColorSquare(value: item.color)
                }
            }
            GridRow {
                ForEach(items[10..<15], id: \.self) { item in
                    ColorSquare(value: item.color)
                }
            }
            GridRow {
                ForEach(items[15..<19], id: \.self) { item in
                    ColorSquare(value: item.color)
                }
            }
        }
        #endif
    }
    
    
    @ViewBuilder
    func ColorSquare(value: Color) -> some View {
        ZStack {
            Rectangle()
                .fill(value)
                .cornerRadius(10)
                .frame(width: 40, height: 40)
            
            if (value == color) {
                Image(systemName: "checkmark")
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
            }
        }
        .onTapGesture {
            color = value
        }
    }
    
    func Circle(color: Color) -> some View {
        Image(systemName: "circle.fill")
            .frame(width: 20, height: 20)
            .foregroundColor(color)
    }
}

struct PickerColor_Previews: PreviewProvider {
    static var previews: some View {
        @State var color: Color = Color(hex: "#f43b30")
        
        PickerColor(color: $color)
    }
}
