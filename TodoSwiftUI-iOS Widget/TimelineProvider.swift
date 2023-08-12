//
//  TimelineProvider.swift
//  TodoSwiftUI-iOS WidgetExtension
//
//  Created by Carlos Eduardo Umaña Acevedo on 10/8/23.
//

import Foundation
import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), lists: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), lists: [ListModel.preview()])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let httpService = HttpService()
        
        Task {
            do {
                let response: ListModelData = try await httpService.fetch(url: "/lists")
                
                let entry = SimpleEntry(date: Date(), lists: response.data)
                
                let nextUpdate = Calendar.current.date(
                    byAdding: DateComponents(minute: 1),
                    to: Date()
                )!
                
                let timeline = Timeline(
                    entries: [entry],
                    policy: .after(nextUpdate)
                )
                
                completion(timeline)
            } catch {
                let timeline = Timeline(entries: [SimpleEntry(date: Date(), lists: [ListModel.preview()])], policy: .never)
                
                completion(timeline)
            }
        }
    }
}
