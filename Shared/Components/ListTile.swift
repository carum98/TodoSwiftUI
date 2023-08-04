//
//  ListTile.swift
//  TodoSwiftUI
//
//  Created by Carlos Eduardo Umaña Acevedo on 3/8/23.
//

import SwiftUI

struct ListTile: View {
    let list: ListModel
    
    var body: some View {
        HStack {
            Image(systemName: "circle.fill")
                .frame(width: 20, height: 20)
                .foregroundColor(Color(hex: list.color))
            Text(list.name)
        }
    }
}

struct ListTile_Previews: PreviewProvider {
    static var previews: some View {
        ListTile(list: ListModel.preview())
    }
}
