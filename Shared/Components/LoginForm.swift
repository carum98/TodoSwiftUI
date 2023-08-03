//
//  LoginForm.swift
//  TodoSwiftUI
//
//  Created by Carlos Eduardo Umaña Acevedo on 2/8/23.
//

import SwiftUI

struct LoginForm: View {
    @StateObject var vm = LoginViewModel(httpService: HttpService())
    
    var body: some View {
        Form {
            TextField("Username", text: $vm.userName)
            SecureField("Password", text: $vm.password)
            
            Button("Log In", action: {
                Task {
                    await vm.login()
                }
            })
            
            Text(vm.token)
        }
    }
}

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm()
    }
}
