//
//  ListRowItemView.swift
//  Devote
//
//  Created by Joel Groomer on 1/14/24.
//

import SwiftUI

struct ListRowItemView: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var item: Item
    
    var body: some View {
        Toggle(isOn: $item.completion) {
            Text(item.task ?? "")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.heavy)
                .foregroundStyle(item.completion ? Color.pink : Color.primary)
                .padding(.vertical, 12)
                .animation(.default, value: item.task)
        } //: Toggle
        .toggleStyle(CheckboxStyle())
        .onReceive(item.objectWillChange, perform: { _ in
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
            }
        })
    }
}
