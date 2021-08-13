//
//  Buttons.swift
//  Reciplease-Beta
//
//  Created by Samuel Royal on 13/08/21.
//  Copyright © 2021 Samuel Royal. All rights reserved.
//

import SwiftUI

struct Buttons: View {
    var body: some View {
            VStack{
                        Text("Add Recipe")
                                   .font(.system(size:20, weight: .semibold, design:
                                       .rounded))
                                   .frame(width: 400, height: 50)
                                   
                                   .background(
                                       ZStack {
                                           Color(#colorLiteral(red: 1, green: 0.6202532053, blue: 0, alpha: 1))
                                           
                                           RoundedRectangle(cornerRadius: 16, style:
                                               .continuous)
                                               .foregroundColor(Color(#colorLiteral(red: 1, green: 0.6202532053, blue: 0, alpha: 1)))
                                               .blur(radius: 4)
                                               .offset(x: -8, y: 8)
                                           RoundedRectangle(cornerRadius: 16, style:
                                               .continuous)
                                           .fill(
                                               LinearGradient(gradient: Gradient(colors: [ Color(#colorLiteral(red: 1, green: 0.6140111685, blue: 0, alpha: 1)),Color(#colorLiteral(red: 1, green: 0.7653594017, blue: 0.3994753361, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                           
                                           )
                                           .padding(2)
                                           .blur(radius: 2)
                                       }
                                   )
                                   .clipShape(RoundedRectangle(cornerRadius: 16, style:
                                       .continuous))
                                   .shadow(color: Color(#colorLiteral(red: 0.8402299285, green: 0.6806161404, blue: 0.5036028624, alpha: 1)), radius: 20, x: 20, y: 20)
                                   .shadow(color: Color(#colorLiteral(red: 1, green: 0.9313164949, blue: 0.8165345788, alpha: 1)), radius: 20, x: -20, y: -20)
                           }
                           .frame(maxWidth: .infinity, maxHeight: .infinity)
                           .background(Color(#colorLiteral(red: 1, green: 0.8606873155, blue: 0.6764089465, alpha: 1)))
                           .edgesIgnoringSafeArea(.all)
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}
