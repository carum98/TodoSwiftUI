//
//  TodoSwiftUI_iOS_Widget.swift
//  TodoSwiftUI-iOS Widget
//
//  Created by Carlos Eduardo Umaña Acevedo on 10/8/23.
//

import WidgetKit
import SwiftUI

struct TodoSwiftUI_iOS_Widget: Widget {
    let kind: String = "TodoSwiftUI_iOS_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            HomeView(entry: entry)
        }
        .configurationDisplayName("Todo SwiftUI")
        .description("Widget to SwiftUI App.")
    }
}

struct TodoSwiftUI_iOS_Widget_Previews: PreviewProvider {
    static var previews: some View {
        let lists = [
            ListModel(id: 1, name: "Work", color: "#FF0000"),
            ListModel(id: 2, name: "University", color: "#FFFF00"),
            ListModel(id: 3, name: "Development", color: "#FF00FF"),
            ListModel(id: 4, name: "Food", color: "#00F2F"),
            ListModel(id: 5, name: "Tools", color: "#F02240"),
            ListModel(id: 1, name: "Work", color: "#FF0000"),
            ListModel(id: 2, name: "University", color: "#FFFF00"),
            ListModel(id: 3, name: "Development", color: "#FF00FF"),
            ListModel(id: 4, name: "Food", color: "#00F2F"),
            ListModel(id: 5, name: "Tools", color: "#F02240"),
        ]
        
        HomeView(entry: SimpleEntry(date: Date(), lists: lists))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
            .previewDisplayName("Medium")
        
        HomeView(entry: SimpleEntry(date: Date(), lists: lists))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            .previewDisplayName("Small")
        
        HomeView(entry: SimpleEntry(date: Date(), lists: lists))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
            .previewDisplayName("Largue")
    }
}
