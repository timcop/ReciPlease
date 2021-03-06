//
//  EditStepView.swift
//  ReciPlease
//
//  Created by Ethan Fraser on 30/09/21.
//

import SwiftUI

/** This is the view for editing steps within the method,
 Features a textEditor for inputing a step and buttons for cancel/submit.
 */
struct EditStepView: View {
    
    @EnvironmentObject var currentRecipe: Recipe
    @Binding var editingStep: Bool
    @State var isNewStep: Bool
    @Binding var currentStep: Step
    @State var stepPlaceholder = "Preheat oven to 180ºC..."
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ZStack {
            Color.white
                .onTapGesture {
                    currentStep = Step()
                    withAnimation {
                        editingStep.toggle()
                    }
                }
                .ignoresSafeArea()
                .opacity(0.01)
                .accessibilityAddTraits(.isButton)
                .accessibilityIdentifier("OutsideEditStep")
            VStack(spacing: 20) {
                ZStack {
                    if currentStep.string.isEmpty {
                        TextEditor(text:$stepPlaceholder)
                            .font(.body)
                            .foregroundColor(.gray)
                            .cornerRadius(8)
                            .disabled(true)
                            .padding()
                            .accessibilityIdentifier("StepTextPlaceholder")
                    }
                    TextEditor(text: $currentStep.string)
                        .font(.body)
                        .opacity(currentStep.string.isEmpty ? 0.25 : 1)
                        .cornerRadius(8)
                        .padding()
                        .accessibilityIdentifier("StepText")
                }
                HStack {
                    Button("Cancel") {
                        currentStep = Step()
                        withAnimation {
                            editingStep.toggle()
                        }
                    }
                    .accessibilityIdentifier("CancelStep")
                    .buttonStyle(GrowingButton())
                    .padding()
                    Button("Submit") {
                        if isNewStep {
                            currentRecipe.method.append(currentStep)
                        } else {
                            let oldMethod = currentRecipe.method
                            currentRecipe.method = []
                            oldMethod.forEach {step in
                                if step.id == $currentStep.id {
                                    currentRecipe.method.append(currentStep)
                                } else {
                                    currentRecipe.method.append(step)
                                }
                            }
                        }
                        currentStep = Step()
                        withAnimation {
                            editingStep.toggle()
                        }
                    }
                    .disabled(currentStep.string.isEmpty)
                    .accessibilityLabel("SubmitStep")
                    .buttonStyle(GrowingButton())
                    .padding()
                }
            }.frame(width:350, height:310)
                .background(Color(.systemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                .shadow(color: .gray, radius: 5, x:-9, y: -9)
        }
    }
}
