//
//  RecipeViewController.swift
//  RecipleaseUI
//
//  Created by Samuel Royal on 2/06/21.
//  Copyright © 2021 Samuel Royal. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    
    @IBOutlet weak var recipe1: UILabel!
    @IBOutlet weak var recipe2: UILabel!
    @IBOutlet weak var recipe3: UILabel!
    @IBOutlet weak var recipe1Image: UIButton!
    @IBOutlet weak var recipe2Image: UIButton!
    @IBOutlet weak var recipe3Image: UIButton!

    
    
    override func viewDidLoad() {
        
        
        if(Data.recipesUnderPrice.count > 0){
            recipe1.text = (Data.RecipeList[Data.recipesUnderPrice[0]].name)
            recipe1Image.setImage(UIImage(named: Data.RecipeList[Data.recipesUnderPrice[0]].Image), for: .normal)
           
        }else{
            recipe1.text = ("Sorry there were no Recipes under your budget :( ")
        }
        if(Data.recipesUnderPrice.count > 1){
            recipe2.text = (Data.RecipeList[Data.recipesUnderPrice[1]].name)
            recipe2Image.setImage(UIImage(named: Data.RecipeList[Data.recipesUnderPrice[1]].Image), for: .normal)
        }else{
            recipe2.text = ("Sorry there were no Recipes under your budget :( ")
        }
        if(Data.recipesUnderPrice.count > 2){
            recipe3.text = (Data.RecipeList[Data.recipesUnderPrice[2]].name)
            recipe3Image.setImage(UIImage(named: Data.RecipeList[Data.recipesUnderPrice[2]].Image), for: .normal)
           
        }else{
            recipe3.text = ("Sorry there were no Recipes under your budget :( ")
        }
        super.viewDidLoad()
        title = "Recipes"
        navigationController?.setNavigationBarHidden(false, animated: false)

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
