//
//  ImagePicker.swift
//  ReciPlease
//
//  Created by Sam Royal on 30/09/21.
//

import SwiftUI
/**
 Allows the user to select an image from their gallery to be presented as the Recipe imgage.
 Controlled by a .onTapGesture that sets showingImagePicker to true,
 in the newAddRecipeView and RecipeDetailView when editing.
 */
struct ImagePicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        /**
         Brings up the image picker for the user.
         */
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage.fixImageOrientation()
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}

/**
 When Images as pngData are loaded out of Core Data, their orientations are wrong.
 This method fixes the orientations of these images.
 */
extension UIImage {
    func fixImageOrientation() -> UIImage {
        UIGraphicsBeginImageContext(self.size)
        self.draw(at: .zero)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
}
