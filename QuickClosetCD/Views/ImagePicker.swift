// Information from
// https://www.hackingwithswift.com/books/ios-swiftui/importing-an-image-into-swiftui-using-uiimagepickercontroller
// https://www.appcoda.com/swiftui-camera-photo-library/

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
  @Environment(\.presentationMode) var presentationMode
  @Binding var image: UIImage?
  @Binding var sourceType: UIImagePickerController.SourceType

  class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
      let parent: ImagePicker

      init(_ parent: ImagePicker) {
          self.parent = parent
      }


    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let uiImage = info[.originalImage] as? UIImage {
            parent.image = uiImage
        }

        parent.presentationMode.wrappedValue.dismiss()
    }
  }

  func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
      let picker = UIImagePickerController()
      picker.sourceType = sourceType
      picker.delegate = context.coordinator
      return picker
  }

  func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    uiViewController.sourceType = sourceType
  }

  func makeCoordinator() -> Coordinator {
      Coordinator(self)
  }
}
