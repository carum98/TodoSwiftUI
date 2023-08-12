//
//  TimelineEntry.swift
//  TodoSwiftUI-iOS WidgetExtension
//
//  Created by Carlos Eduardo Umaña Acevedo on 10/8/23.
//

import WidgetKit
import Foundation

struct SimpleEntry: TimelineEntry {
    let date: Date
    let lists: [ListModel]?
}
