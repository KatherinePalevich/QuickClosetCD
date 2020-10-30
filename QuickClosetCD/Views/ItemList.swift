//
//  ContentView.swift
//  ItemsCD
//
//  Created by Jack Palevich on 10/17/20.
//

import SwiftUI
import CoreData

enum SortOrder {
  case byName
  case byCategory
  mutating func toggle() {
    switch self {
    case .byName:
      self = .byCategory
    case .byCategory:
      self = .byName
    }
  }

}

struct ItemList: View {
  var body: some View {
    NavigationView {
      ItemList2()
    }
  }
}

struct ItemList2: View {
  @State private var sortOrder: SortOrder = .byName
  private var didSave = NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave)

  var body: some View {
    ItemList3(fetchRequest:fetchRequest, sortOrder: $sortOrder)
      .onReceive(didSave) {_ in
        // CoreData doesn't automatically fetchf when relations change.
        if sortOrder == .byName {
          // Toggle twice has the effect of forcing a new fetch request to be made.
          sortOrder.toggle()
          sortOrder.toggle()
        }
      }
  }

  private var fetchRequest: FetchRequest<Item> {
    switch sortOrder {
    case .byName:
      return FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.name, ascending: true)])
    case .byCategory:
      return FetchRequest(sortDescriptors: [NSSortDescriptor(key: "Category.name", ascending: true)])
    }
  }
}

struct ItemList3: View {
  @Environment(\.managedObjectContext) private var viewContext

  var fetchRequest:FetchRequest<Item>

  @Binding var sortOrder: SortOrder

  private var items: FetchedResults<Item> {
    fetchRequest.wrappedValue
  }

  /// Controls the presentation of the item creation sheet.
  @State private var newItemIsPresented = false

  var body: some View {
    itemList
      .navigationBarTitle(Text("\(items.count) Items"))
      .navigationBarItems(
        leading: HStack {
          EditButton()
          newItemButton
        },
        trailing: toggleOrderingButton)
  }

  private var itemList: some View {
    List {
      ForEach(items) { item in
        NavigationLink(destination: editorView(for: item)) {
          ItemRow(item: item)
            .animation(nil)
        }
      }
      .onDelete(perform: deleteItems)
    }
    .listStyle(PlainListStyle())
  }

  /// The view that edits a item in the list.
  private func editorView(for item: Item) -> some View {
    ItemEditor(
      context:viewContext,
      item: item)
      .navigationBarTitle(item.wrappedName)
  }

  /// The button that presents the item creation sheet.
  private var newItemButton: some View {
    Button(
      action: {
        self.newItemIsPresented = true
      },
      label: { Image(systemName: "plus").imageScale(.large) })
      .sheet(
        isPresented: $newItemIsPresented,
        content: { self.newItemCreationSheet })
  }

  /// The item creation sheet.
  private var newItemCreationSheet: some View {
    let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    childContext.parent = viewContext
    return ItemCreationSheet(
      context:childContext,
      item: Item(context: childContext),
      dismissAction: {
        self.newItemIsPresented = false
        do {
          try viewContext.save()
        } catch {
          // Replace this implementation with code to handle the error appropriately.
          // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
          let nsError = error as NSError
          fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }

      })
  }

  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      offsets.map { items[$0] }.forEach(viewContext.delete)

      do {
        try viewContext.save()
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }

  /// The button that toggles between title/author ordering.
  private var toggleOrderingButton: some View {
    switch sortOrder {
    case .byName:
      return Button(action: toggleSortOrder, label: {
        HStack {
          Text("Title")
          Image(systemName: "arrowtriangle.up.fill")
            .imageScale(.small)
        }
      })
    case .byCategory:
      return Button(action: toggleSortOrder, label: {
        HStack {
          Text("Author")
          Image(systemName: "arrowtriangle.up.fill")
            .imageScale(.small)
        }
      })
    }
  }

  private func toggleSortOrder() {
    sortOrder.toggle()
  }
}

struct ItemRow: View {
  @ObservedObject var item: Item

  var body: some View {
    VStack(alignment:.leading) {
      Text(item.wrappedName)
      Text(item.categoryName)
    }
  }
}

struct ItemList_Previews: PreviewProvider {
  static var previews: some View {
    Group {
        item.colorScheme(.light)
        item.colorScheme(.dark)
    }
    .previewLayout(.sizeThatFits)
   
  }
    static var item: some View {
        ItemList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .accentColor(.yellow)
    }
}
