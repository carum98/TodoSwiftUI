//
//  TodoSwiftUI_iOS_WidgetBundle.swift
//  TodoSwiftUI-iOS Widget
//
//  Created by Carlos Eduardo Umaña Acevedo on 10/8/23.
//

import WidgetKit
import SwiftUI

@main
struct TodoSwiftUI_iOS_WidgetBundle: WidgetBundle {
    var body: some Widget {
        TodoSwiftUI_iOS_Widget()
        TodoSwiftUI_iOS_WidgetLiveActivity()
    }
}
