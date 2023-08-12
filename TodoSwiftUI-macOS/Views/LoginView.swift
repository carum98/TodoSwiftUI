//
//  LoginView.swift
//  TodoSwiftUI-macOS
//
//  Created by Carlos Eduardo Umaña Acevedo on 12/8/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject var vm = LoginViewModel()
    
    var body: some View {
        Form {
            Text("Login")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
            
            TextField("", text: $vm.userName, prompt: Text("Username"))
                .labelsHidden()
            SecureField("", text: $vm.password, prompt: Text("Password"))
                .labelsHidden()
            
            Button("Login") {
                Task {
                    await vm.login()
                }
            }
            .disabled(vm.disabled)
            .background(vm.disabled ? .gray.opacity(0.4) : .blue)
            .frame(maxWidth: .infinity)
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .frame(width: 300)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
