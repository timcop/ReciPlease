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
        Buttons()
        
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}

public class Buttons1{
   
    
    struct AddRecipeButton: View{
        
        var body: some View{
            Text("Add Recipe")
                .font(Font.custom("BebasNeue-Regular",size: 20))
                .frame(width: UIScreen.main.bounds.width - 25, height: 50)
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
        
        
    }
    
    struct RecipeFinderButton: View{
        @State var tap = false
        
        var body: some View{
            Text("Find me a Recipe")
                .font(Font.custom("BebasNeue-Regular",size: 20))
                .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                
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
    }
    struct FillProds: View{
           @State var tap = false
           
           var body: some View{
               Text("Find me a Recipe")
                   .font(Font.custom("BebasNeue-Regular",size: 20))
                   .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                   
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
                   .scaleEffect(tap ? 1.02:1)
                   .onTapGesture {
                       self.tap = true
                       DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
                           self.tap=false
                       }
                       
               }
           }
       }
    struct BrowseRecipesButton: View{
        @State var tap = false
        
        var body: some View{
            Text("Browse your Recipes")
                .font(Font.custom("BebasNeue-Regular",size: 20))
                .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                
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
    }
    
    struct AddButton: View{
        @State var tap = false
       // @StateObject var ingredient = AddRecipe()
        var body: some View{
            Text("+")
                .font(Font.custom("BebasNeue-Regular",size: 20))
                .frame(width: 50, height: 40)
                
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
    }
    
    
    
    struct ImageButton: View{
        @State var tap = false
        var body: some View{
            Text("Add Image")
                .font(Font.custom("BebasNeue-Regular",size: 20))
                .frame(width: 125, height: 40)
                
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
                .scaleEffect(tap ? 1.02:1)
                .onTapGesture {
                    self.tap = true
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
                        
                        self.tap=false
                    }
                    
            }
        }
    }
    
    struct FinalAddRecipeButton: View{
        @State var tap = false
        
        
        
        var body: some View{
            Text("Add Recipe")
                .font(Font.custom("BebasNeue-Regular",size: 20))
                .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                
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
    }
}



