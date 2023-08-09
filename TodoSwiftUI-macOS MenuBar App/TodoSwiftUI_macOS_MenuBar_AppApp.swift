//
//  TodoSwiftUI_macOS_MenuBar_AppApp.swift
//  TodoSwiftUI-macOS MenuBar App
//
//  Created by Carlos Eduardo Umaña Acevedo on 8/8/23.
//

import SwiftUI

@main
struct TodoSwiftUI_macOS_MenuBar_AppApp: App {
    var body: some Scene {
        MenuBarExtra("App Menu ToDo App", systemImage: "dot.circle.and.hand.point.up.left.fill") {
            ContentView()
        }
        .menuBarExtraStyle(.window)
    }
}
