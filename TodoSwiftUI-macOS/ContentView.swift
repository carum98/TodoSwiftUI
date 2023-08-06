//
//  ContentView.swift
//  TodoSwiftUI-macOS
//
//  Created by Carlos Eduardo Umaña Acevedo on 2/8/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authViewModel = AuthViewModel.shared
    
    var body: some View {
        if authViewModel.isAuth {
            HomeView()
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
