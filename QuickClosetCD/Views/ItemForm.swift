import SwiftUI
import CoreData

/// The Item editor form, embedded in both
/// `ItemCreationSheet` and `ItemEditor`.
struct ItemForm: View {
    /// Manages the item form
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var item: Item
    @State private var showingImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    private let pasteboard = UIPasteboard.general

    var body: some View {
        List {
            TextField("Item", text: $item.wrappedName)
            NavigationLink(destination: categoryPicker){
                Text(item.categoryNames.sorted().joined(separator: ", "))
            }
          if let photo = item.wrappedPhoto {
            Image(uiImage: photo)
              .resizable()
              .scaledToFit()
          }
          Menu("Edit Photo") {
              Button("Paste", action: paste)
                // TODO: Figure out how to enable/disable based on if images are available.
                /// .disabled(!UIPasteboard.general.hasImages)
              Button("Camera", action: camera)
                .disabled(!UIImagePickerController.isCameraDeviceAvailable(.rear))
              Button("Gallery", action: gallery)
              Button("Clear", action: clearPhoto)
          }
          .sheet(isPresented: $showingImagePicker, onDismiss: {}) {
            ImagePicker(image: $item.wrappedPhoto, sourceType: $sourceType)
          }
        }
        .listStyle(GroupedListStyle())
    }
    @State var selection: Set<String> = Set(["Top"])

    var categoryPicker : some View {
        let categoryNames = Category.allCategoryNames(context: viewContext)
        return CategoryPicker(selection: $item.categoryNames, choices: Set(categoryNames)){
            Text($0)
        }
    }
    
  func paste() {
    if pasteboard.hasImages {
      item.wrappedPhoto = pasteboard.image
    }
  }

  func camera() {
    sourceType = .camera
    showingImagePicker = true
  }

  func gallery() {
    sourceType = .photoLibrary
    showingImagePicker = true
  }

  func clearPhoto() {
    item.photo = nil
  }

}

struct ItemForm_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
