//
//  LoginView.swift
//  TodoSwiftUI-iOS
//
//  Created by Carlos Eduardo Umaña Acevedo on 12/8/23.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject var vm = LoginViewModel()
    
    var textFieldColor: Color {
        return colorScheme == .dark ? .gray.opacity(0.6) : .gray.opacity(0.1)
    }
    
    var body: some View {
        Form {
            VStack(spacing: 20) {
                Text("Login")
                    .font(.title)
                    .fontWeight(.bold)
                
                TextField("Username", text: $vm.userName)
                    .padding(11)
                    .background(textFieldColor)
                    .cornerRadius(10)
                
                SecureField("Password", text: $vm.password)
                    .padding(11)
                    .background(textFieldColor)
                    .cornerRadius(10)
                
                Button("Login") {
                    Task {
                        await vm.login()
                    }
                }
                    .padding(10)
                    .frame(maxWidth: 250)
                    .foregroundColor(vm.disabled ? .black.opacity(0.4) : .white)
                    .background(vm.disabled ? .gray.opacity(0.4) : .blue)
                    .cornerRadius(10)
                    .disabled(vm.disabled)
                
                
                Button("Register") {
                    
                }
            }
        }
        .formStyle(.columns)
        .frame(width: 300)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

