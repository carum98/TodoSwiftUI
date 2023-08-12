//
//  LoginView.swift
//  TodoSwiftUI-watchOS Watch App
//
//  Created by Carlos Eduardo Umaña Acevedo on 12/8/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject var vm = LoginViewModel()
    
    var body: some View {
        Form {
            TextField("Username", text: $vm.userName)
            SecureField("Password", text: $vm.password)
            
            Button("Login") {
                Task {
                    await vm.login()
                }
            }
            .disabled(vm.disabled)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
