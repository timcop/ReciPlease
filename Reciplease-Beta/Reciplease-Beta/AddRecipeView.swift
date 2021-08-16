//
//  AddRecipeView.swift
//  Reciplease-Beta
//
//  Created by Samuel Royal on 13/08/21.
//  Copyright © 2021 Samuel Royal. All rights reserved.
//

import SwiftUI
import Combine


struct AddRecipeView: View {
    @State var title = ""
    @State var searchText = ""
    @State var method = ""
    @State var description = ""
    @State var servingSize = ""
    @State var ingredient = ""
    @State var ingredients: [String] = [""]
    @State var tap = false
    @State var placeheolder = ""
    @State var quant = ""
    @State var quantsofIngredients: [String] = [""]
    @State var quantities: [Double] = [0]
    var ingredientsAlreadyHave: [String] = []
    var quantsofIAH: [Int] = []
    var staplesPPP: [Int] = []
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    
    
    var count: Int = 0
    init(){
        UITextView.appearance().backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    
    
    
    
    var body: some View {
        
        ZStack{
            VStack{
                ScrollView{
                    Text("RECIPLEASE").font(Font.custom("BebasNeue-Regular",size: 50))
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    Spacer()
                        .frame(height:53)
                    HStack{
                        
                        TextField("Title",text: $title)
                            .multilineTextAlignment(TextAlignment.center)
                            .frame(width: UIScreen.main.bounds.width-170,height:40)
                            .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 12, style:
                                .continuous))
                            .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        Buttons1.ImageButton()
                        // .randomBorder()
                    }
                    .frame(width: UIScreen.main.bounds.width - 20)
                    
                    
                    HStack{
                        TextField("Description",text: $description)
                            // .randomBorder()
                            .multilineTextAlignment(TextAlignment.center)
                            .frame(width: UIScreen.main.bounds.width-170,height:40)
                            .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 12, style:
                                .continuous))
                            .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        TextField("Serving Size",text: $servingSize)
                            //.randomBorder()
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(TextAlignment.center)
                            .frame(width: UIScreen.main.bounds.width-290,height:40)
                            .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 12, style:
                                .continuous))
                            .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                            .onReceive(Just(servingSize)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.servingSize = filtered
                                }
                        }
                        
                    }
                    
                    VStack{
                            ZStack{
                                Picker("",selection: $ingredient){
                                    
                                    ForEach(Data.Ingredients.filter({ searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased()) }), id: \.name) {item in
                                        Text(item.name + "| Unit: " + item.unit).font(.system(size: 10))                            }
                                }
                                .frame(height: 200)
                                .clipped()
                                .offset(x: -48, y: 50)
                                SearchBar(text: $searchText,placeholder: "Ingredients...")
                                    .frame(width: UIScreen.main.bounds.width-75)
                                //.randomBorder()
                                
                            }
                            .frame(height: 50)
                            
                        Spacer()
                            .frame(height:130)
                        HStack{
                            TextField("Quantity",text: $quant)
                                //.randomBorder()
                                
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(TextAlignment.center)
                                .frame(width: UIScreen.main.bounds.width*0.30,height:40)
                                .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                                .clipShape(RoundedRectangle(cornerRadius: 12, style:
                                    .continuous))
                                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                .onReceive(Just(quant)) { newValue in
                                    let filtered = newValue.filter { "0123456789".contains($0) }
                                    if filtered != newValue {
                                        self.quant = filtered
                                    }
                            }
                            Buttons1.AddButton()
                                //.randomBorder()
                                .scaleEffect(tap ? 1.02:1)
                                .onTapGesture {
                                    if(Double(self.quant) != nil){
                                        if !self.ingredients.contains(self.ingredient){
                                            self.ingredients.append(self.ingredient)
                                            self.quantsofIngredients.append(self.quant)
                                            self.quantities.append(Double(self.quant)!)
                                            self.quant=""
                                        }
                                    }
                                    self.tap = true
                                    DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
                                        self.tap=false
                                    }
                            }
                        }
                        
                        
                        
                    }
                    
                    Spacer().frame(height: 20)
                    
                    VStack{
                        Text("Ingredient List").font(Font.custom("BebasNeue-Regular",size: 20))
                            //.randomBorder()
                            .padding(15)
                            .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                            .frame(width: UIScreen.main.bounds.width - 15,alignment: .leading)
                        HStack {
                            Text(returnArrayinStringForm2(array: self.quantsofIngredients))
                                .font(Font.custom("BebasNeue-Regular",size: 13))
                            Text(returnArrayinStringForm2(array:self.ingredients))
                                .font(Font.custom("BebasNeue-Regular",size: 13))
                                .frame(width: UIScreen.main.bounds.width-70, alignment: .leading)
                            Button(action: {
                                if self.ingredients.count > 1 {
                                    self.ingredients.remove(at:  self.ingredients.firstIndex(of: self.ingredients[self.ingredients.count-1]) ?? 0)
                                    self.quantsofIngredients.remove(at: self.quantsofIngredients.firstIndex(of: self.quantsofIngredients[self.quantsofIngredients.count-1]) ?? 0)
                                    self.quantities.remove(at: self.quantities.firstIndex(of: self.quantities[self.quantities.count-1]) ?? 0)
                                }
                            }) {
                                if self.ingredients.count > 1{
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.secondary)
                                        .frame(alignment: .bottom)
                                }
                            }
                        }
                        
                     
                        
                        
                        
                        
                        Text("Method").font(Font.custom("BebasNeue-Regular",size: 20))
                            .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                            .frame(width: UIScreen.main.bounds.width-40, alignment: .leading)
//                        TextEditor(text: $method)
//                            .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
//                            .frame(width: UIScreen.main.bounds.width-20, height: 200)
//                            .clipShape(RoundedRectangle(cornerRadius: 12, style:
//                                .continuous))
                        Spacer()
                            .frame(height: 50)
                        NavigationLink(destination: ContentView()){
                            Buttons1.FinalAddRecipeButton()
                                .onTapGesture {
                                    Data.addRecipe(n: self.title, method: self.method, description: self.description, Ing: self.ingredients, Quants: self.quantities, Serving: Int(self.servingSize) ?? 0, Image: "", staples: self.ingredientsAlreadyHave, staplesQuant: self.quantsofIAH, staplesPPP: self.staplesPPP)
                                    sleep(1)
                                    self.mode.wrappedValue.dismiss()
                            }
                            
                            
                        }
                    }
                    
                }
                .frame(height: UIScreen.main.bounds.height - 50,alignment: .top)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(#colorLiteral(red: 1, green: 0.8612575531, blue: 0.6343607306, alpha: 1)))
            .edgesIgnoringSafeArea(.all)
        }
    }
}


func returnArrayinStringForm2(array: [String]) ->String{
    var s = ""
    for i in 0..<array.count{
        s += array[i]+"\n"
    }
    return(s)
    
}


