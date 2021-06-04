//
//  HomePageViewController.swift
//  RecipleaseUI
//
//  Created by Samuel Royal on 2/06/21.
//  Copyright © 2021 Samuel Royal. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    @IBOutlet var field1 : UITextField!
    @IBOutlet var field2 : UITextField!
    @IBOutlet var button : UIButton!
    
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
    
                // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        field1.text = ""
        field2.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
            
    @IBAction func buttonTapped(){
        Data.recipesUnderPrice = []
        let servingNumber = Double(field2.text ?? "") ?? 0
        let userPrice = Double(field1.text ?? "") ?? 0
        for i in 0..<Data.RecipeList.count {
            let price  = Data.priceRecipe(recNum: i)
            print(price)
            let serving = Double(Data.RecipeList[i].Serving)
            let finalPrice = (servingNumber/serving)*price
            print(finalPrice)
            if(finalPrice <= userPrice){
                Data.recipesUnderPrice.append(i)
                
                
                
            }
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let vc3 = self.storyboard?.instantiateViewController(identifier: "Recipes") as! RecipeViewController
            self.navigationController?.pushViewController(vc3,animated: false)
        }
    }
    

}

