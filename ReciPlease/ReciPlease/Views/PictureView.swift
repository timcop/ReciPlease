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
        
        Image(uiImage: uiImage)
            .resizable()
            .scaledToFill()
            .frame(width: 300, height: 300)
            .cornerRadius(15)
            .clipped()
    }
}
