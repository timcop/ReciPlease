//
//  1stRecipe.swift
//  RecipleaseUI
//
//  Created by Samuel Royal on 3/06/21.
//  Copyright © 2021 Samuel Royal. All rights reserved.
//

import UIKit

class FirstRecipe: UIViewController {
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var des: UILabel!
    @IBOutlet weak var serves: UILabel!
    @IBOutlet weak var quant: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    @IBOutlet weak var method: UILabel!
    @IBOutlet weak var price: UILabel!
    override func viewDidLoad() {
       header.text = (Data.RecipeList[Data.recipesUnderPrice[0]].name)
       des.text = (Data.RecipeList[Data.recipesUnderPrice[0]].description)
       for i in 0..<Data.RecipeList[Data.recipesUnderPrice[0]].Quants.count {
            quant.text?.append(String(Int(Data.RecipeList[Data.recipesUnderPrice[0]].Quants[i])))
            quant.text?.append("\n")
        }
        serves.text = String(Data.RecipeList[Data.recipesUnderPrice[0]].Serving)
        method.text = Data.RecipeList[Data.recipesUnderPrice[0]].method
        for i in 0..<Data.RecipeList[Data.recipesUnderPrice[0]].Ingredients.count {
            ingredients.text?.append((Data.RecipeList[Data.recipesUnderPrice[0]].Ingredients[i]))
            ingredients.text?.append("\n")
        }
       // method.text = Data.RecipeList[Data.price].price

        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
