//
//  FormListView.swift
//  TodoSwiftUI
//
//  Created by Carlos Eduardo Umaña Acevedo on 5/8/23.
//

import SwiftUI

struct FormListView: View {
    let onSave: () -> Void
    
    let listViewModel: ListViewModel
    let list: ListModel?
    
    @State var name: String
    
    init(list: ListModel?, listViewModel: ListViewModel, onSave: @escaping () -> Void) {
        self.list = list
        self.listViewModel = listViewModel
        self.onSave = onSave
        
        _name = State(initialValue: list?.name ?? "")
    }
    
    func save() {
        Task {
            if (list != nil) {
                await listViewModel.update(id: list!.id, name: name, color: "#FF0000")
            } else {
                await listViewModel.create(name: name, color: "#FF0000")
            }
            
            onSave()
        }
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $name)
            }
            
            Section {
                Button(list == nil ? "Save" : "Update", action: save)
            }
        }
    }
}

struct FormListView_Previews: PreviewProvider {
    static var previews: some View {
        FormListView(
            list: ListModel.preview(),
            listViewModel: ListViewModel()
        ) {
            print("onSave")
        }
    }
}
