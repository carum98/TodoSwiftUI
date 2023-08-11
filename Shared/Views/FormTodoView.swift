//
//  FormTodoView.swift
//  TodoSwiftUI
//
//  Created by Carlos Eduardo Umaña Acevedo on 5/8/23.
//

import SwiftUI

struct FormTodoView: View {
    let onSave: () -> Void
    
    let todoViewModel: TodoViewModel
    let todo: TodoModel?
    let list: ListModel
    
    @State var title: String
    
    init(todo: TodoModel?, list: ListModel, todoViewModel: TodoViewModel, onSave: @escaping () -> Void) {
        self.todo = todo
        self.todoViewModel = todoViewModel
        self.onSave = onSave
        self.list = list
        
        _title = State(initialValue: todo?.title ?? "")
    }
    
    func save() {
        Task {
            if (todo != nil) {
                await todoViewModel.update(todo: todo!, title: title)
            } else {
                await todoViewModel.create(list: list, title: title)
            }
            
            onSave()
        }
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $title)
            }
            
            Section {
                Button(todo == nil ? "Save" : "Update", action: save)
            }
        }
//        #if os(macOS)
//        .frame(width: 300)
//        .padding(30)
//        #endif
        .formStyle(.grouped)
    }
}

struct FormTodoView_Previews: PreviewProvider {
    static var previews: some View {
        FormTodoView(
            todo: TodoModel.preview(),
            list: ListModel.preview(),
            todoViewModel: TodoViewModel()
        ) {
            print("onSave")
        }
    }
}
