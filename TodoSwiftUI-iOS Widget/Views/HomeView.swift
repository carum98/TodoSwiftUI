//
//  HomeView.swift
//  TodoSwiftUI-iOS WidgetExtension
//
//  Created by Carlos Eduardo Umaña Acevedo on 10/8/23.
//

import SwiftUI
import WidgetKit

struct HomeView: View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    
    var entry: Provider.Entry
    
    func max() -> Int {
        switch family {
            case .systemSmall:
                return 4
            case .systemMedium:
                return 4
            case .systemLarge:
                return 8
            default:
                return  10
        }
    }
    
    var body: some View {
        if let lists = entry.lists?.prefix(max()) {
            VStack(alignment: .trailing) {
                ForEach(lists) { item in
                    HStack {
                        Image(systemName: "circle.fill")
                            .frame(width: 15, height: 15)
                            .foregroundColor(Color(hex: item.color))
                        Text(item.name)
                        Spacer()
                    }
                    .font(.system(size: 17))
                    
                    if item != lists.last {
                        Divider()
                    }
                }
            }.padding(20)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let lists = [
            ListModel(id: 1, name: "Work", color: "#FF0000", count: 2),
            ListModel(id: 2, name: "University", color: "#FFFF00", count: 2),
            ListModel(id: 3, name: "Development", color: "#FF00FF", count: 0),
            ListModel(id: 4, name: "Food", color: "#00F2F", count: 1),
            ListModel(id: 5, name: "Tools", color: "#F02240", count: 4),
            ListModel(id: 1, name: "Work", color: "#FF0000", count: 0),
            ListModel(id: 2, name: "University", color: "#FFFF00", count: 1),
            ListModel(id: 3, name: "Development", color: "#FF00FF", count: 1),
            ListModel(id: 4, name: "Food", color: "#00F2F", count: 0),
            ListModel(id: 5, name: "Tools", color: "#F02240", count: 3),
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
