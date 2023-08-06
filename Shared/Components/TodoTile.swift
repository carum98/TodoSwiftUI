//
//  TodoTile.swift
//  TodoSwiftUI
//
//  Created by Carlos Eduardo Umaña Acevedo on 5/8/23.
//

import SwiftUI

struct TodoTile: View {
    let todo: TodoModel
    
    var body: some View {
        HStack {
            Image(systemName: todo.is_complete ? "record.circle" : "circle")
                .foregroundColor(todo.is_complete ? .blue : nil)
            Text(todo.title)
        }
    }
}

struct TodoTile_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TodoTile(todo: TodoModel.preview())
                .previewLayout(.fixed(width: 300, height: 100))
            
            TodoTile(todo: TodoModel.preview())
                .previewLayout(.fixed(width: 300, height: 100))
        }
    }
}
