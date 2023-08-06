//
//  ContentView.swift
//  TodoSwiftUi
//
//  Created by Carlos Eduardo Umaña Acevedo on 1/8/23.
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
