//
//  PictureView.swift
//  ReciPlease
//
//  Created by Tim Copland on 2/10/21.
//

import SwiftUI

let screenSize: CGRect = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
/**
 View that easily fornats the images selected by the user.
 */
struct PictureView: View {
    var uiImage: UIImage
    var body: some View {
        
        Image(uiImage: rotateImage(image: uiImage)!)
            .resizable()
            .scaledToFill()
            .frame(width: 300, height: 300)
            .cornerRadius(15)
            .clipped()
    }
}


/**
 If an image is the wrong orientation when it is loaded from core date the
  rotateImage function corrects the orientation.
 */
func rotateImage(image: UIImage) -> UIImage? {
    if (image.imageOrientation == UIImage.Orientation.up ) {
        return image
    }
    UIGraphicsBeginImageContext(image.size)
    image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
    let copy = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return copy
}
