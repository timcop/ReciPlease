//
//  MethodListView.swift
//  ReciPlease
//
//  Created by Ethan Fraser on 30/09/21.
//

import SwiftUI

struct MethodListView: View {
    @StateObject var currentRecipe: Recipe
    @Binding var isNewStep: Bool
    @Binding var currentStep: Step
    @Binding var editingStep: Bool
    @Binding var editingRecipe: Bool
    
    var body: some View {
        ForEach(currentRecipe.method) { step in
            HStack {
                Text("• \(step.string)")
                    .padding(.leading, 10)
                Spacer()
                if (editingRecipe) {
                    Spacer()
                    HStack {
                        Image(systemName:"pencil")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(Color.orange)
                            .padding(.trailing, 18)
                            .onTapGesture {
                                isNewStep = false
                                currentStep = step
                                editingStep.toggle()
                            }
                        Image(systemName:"xmark")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(Color.orange)
                            .onTapGesture {
                                if let index = currentRecipe.method.firstIndex(where: {$0.id == step.id}) {
                                    currentRecipe.method.remove(at: index)
                                } else {
                                    print("not found")
                                }
                            }
                    }.padding(.trailing)
                }
            }
            Spacer(minLength: 25)
        }
    }
}
