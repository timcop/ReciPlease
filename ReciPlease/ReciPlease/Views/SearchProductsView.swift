//
//  SearchProductsView.swift
//  ProductTest
//
//  Created by Tim Copland on 23/09/21.
//

import SwiftUI

/** Navigated to from EditIngredientView() with some searchText.
 Searches the www.countdown.co.nz api for a product(s) containing the search text.
 The returned products are then displayed as a List, with onTapGesture setting the currentIngredient.product
 to the product tapped on.
 */
struct SearchProductsView: View {
    @StateObject var currentRecipe: Recipe
    var productsModel = ProductsModel()
    @State private var products = [Product]()
    @State var hasSearched = false
    @Binding var searchText: String
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView {
            if products.count < 1 && hasSearched {
                Text("No results")
            }
            // List the products returned
            List(products) {prod in
                HStack {
                    // Name and price details of the product
                    VStack(alignment: .leading, spacing: 5) {
                        Text(prod.name.capitalized)
                            .font(.headline).bold().italic()

                        HStack {
                            if (prod.priceDetails.isSpecial) {
                                Text("$\(prod.priceDetails.originalPrice, specifier: "%.2f")").strikethrough()
                                Text("$\(prod.priceDetails.salePrice, specifier: "%.2f")").foregroundColor(.red)
                            } else {
                                Text("$\(prod.priceDetails.originalPrice, specifier: "%.2f")")
                            }
                        }
                    }
                    
                    Spacer()
                    
                    // Displays the image of the product
                    AsyncImageHack(url: URL(string: prod.img.imageURL)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                                .interpolation(.none)
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                        case .failure:
                            Image(systemName: "photo")
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                .onTapGesture {
                    currentRecipe.currentIngredient.product = prod
                    print(currentRecipe.currentIngredient.product?.img.imageURL as Any)
                    self.presentation.wrappedValue.dismiss()
                }
            }
            .navigationTitle("Products")
        }.navigationViewStyle(StackNavigationViewStyle())
        .searchable(text: $searchText)
        .onSubmit(of: .search) {
            hasSearched = true
            Task {
                if !searchText.isEmpty {
                    products = try! await productsModel.getProducts(searchTerm: searchText)
                    //print(products[0].name)
                } else {
                    products = []
                }
            }
        }
        Spacer()
    }

}


/** Loads an image from a URL -  In the countdown website returns a URL for a certain product image*/
struct AsyncImageHack<Content> : View where Content : View {

    let url: URL?
    @ViewBuilder let content: (AsyncImagePhase) -> Content

    @State private var currentUrl: URL?
    
    var body: some View {
        AsyncImage(url: currentUrl, content: content)
        .onAppear {
            if currentUrl == nil {
                DispatchQueue.main.async {
                    currentUrl = url
                }
            }
        }
    }
}
