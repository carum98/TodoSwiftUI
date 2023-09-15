//
//  FormListView.swift
//  TodoSwiftUI
//
//  Created by Carlos Eduardo Umaña Acevedo on 5/8/23.
//

import SwiftUI

enum FocusedField {
    case name, color
}

struct FormListView: View {
    let onSave: () -> Void
    
    let listViewModel: ListViewModel
    let list: ListModel?
    
    @State var name: String
    @State var color: Color
    
    @FocusState private var focusedField: FocusedField?
    
    init(list: ListModel?, listViewModel: ListViewModel, onSave: @escaping () -> Void) {
        self.list = list
        self.listViewModel = listViewModel
        self.onSave = onSave
        
        _name = State(initialValue: list?.name ?? "")
        _color = State(initialValue: list != nil ? Color(hex: list!.color) : Color(hex: "#f43b30"))
    }
    
    func save() {
        Task {
            if (list != nil) {
                await listViewModel.update(id: list!.id, name: name, color: color)
            } else {
                await listViewModel.create(name: name, color: color)
            }
            
            onSave()
        }
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $name)
                    .focused($focusedField, equals: .name)
                HStack {
                    Spacer()
                    PickerColor(color: $color)
                    Spacer()
                }
            }
            
            Section {
                Button(list == nil ? "Save" : "Update", action: save)
            }
        }
        #if os(macOS)
        .frame(width: 300)
        .padding(30)
        #endif
        .onAppear {
            focusedField = .name
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
