//
//  ContentView.swift
//  Devote
//
//  Created by Joel Groomer on 1/11/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - PROPERTIES
    @State private var task: String = ""

    // MARK: - FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    // MARK: - FUNCTIONS
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()
            
            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 16) {
                    TextField("New Task", text: $task)
                        .padding()
                        .background(
                            Color(UIColor.systemGray6)
                        )
                        .clipShape(.rect(cornerRadius: 10))
                    
                    Button {
                        addItem()
                    } label: {
                        Spacer()
                        Text("SAVE")
                        Spacer()
                    }
                    .padding()
                    .font(.headline)
                    .foregroundStyle(.white)
                    .background(Color.pink)
                    .clipShape(.rect(cornerRadius: 10))
                } //: New Task VStack
                .padding()
                
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                        } label: {
                            VStack(alignment: .leading) {
                                Text(item.task ?? "")
                                    .fontWeight(.bold)
                                
                                Text(item.timestamp!, formatter: itemFormatter)
                                    .foregroundStyle(.gray)
                                .font(.footnote)
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            } //: VStack
            .navigationTitle("Daily Tasks")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            } //: toolbar
            Text("Select an item")
        } //: Navigation
    }
}

// MARK: - PREVIEW
#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
