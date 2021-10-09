//
//  PictureView.swift
//  ReciPlease
//
//  Created by Tim Copland on 2/10/21.
//

import SwiftUI

import SwiftUI
//
let screenSize: CGRect = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
//
struct PictureView: View {
    var uiImage: UIImage
    var body: some View {
        
//        Image(uiImage: UIImage(data: recipe.uiImage!.photo)!)
        Image(uiImage: uiImage)
            .resizable()
//            .aspectRatio(contentMode: .fit)
            .frame(width: 300, height: 300)
            .scaledToFit()
            .cornerRadius(15)
    }
}
