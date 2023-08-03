//
//  ContentView.swift
//  TodoSwiftUI-watchOS Watch App
//
//  Created by Carlos Eduardo Umaña Acevedo on 2/8/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authViewModel = AuthViewModel.shared
    
    var body: some View {
        Group {
            if authViewModel.isAuth {
                ListView()
            } else {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
