//
//  ContentView.swift
//  TodoSwiftUI-macOS MenuBar App
//
//  Created by Carlos Eduardo Umaña Acevedo on 8/8/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authViewModel = AuthViewModel.shared
    
    var body: some View {
        if authViewModel.isAuth {
            HomeView()
        } else {
            LoginView()
                .padding(20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
