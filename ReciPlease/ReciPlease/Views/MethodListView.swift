//
//  MethodListView.swift
//  ReciPlease
//
//  Created by Ethan Fraser on 30/09/21.
//

import SwiftUI

struct MethodListView: View {
    var recipe: Recipe
    var method: [Step]
    @Binding var isNewStep: Bool
    @Binding var currentStep: Step
    @Binding var editingStep: Bool
    var body: some View {
        ForEach(method) { step in
            Text("• \(step.string)")
                .padding(.horizontal)
                .padding(.vertical, 4.0)
                .onTapGesture {
                    isNewStep = false
                    currentStep = step
                    editingStep.toggle()
                }
        }
    }
}

//struct MethodListView_Previews: PreviewProvider {
//    @State var editingStep = true
//    static var previews: some View {
//        MethodListView(recipe: Recipe())
//    }
//}
