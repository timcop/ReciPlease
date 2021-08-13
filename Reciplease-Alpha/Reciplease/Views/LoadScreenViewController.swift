//
//  LoadScreenViewController.swift
//  RecipleaseUI
//
//  Created by Samuel Royal on 3/06/21.
//  Copyright © 2021 Samuel Royal. All rights reserved.
//

import UIKit

class LoadScreenViewController: UIViewController {

    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Data.fillProds()
        sleep(3)
        Data.addRecipe(n: "Vegetable Lasagne", method: "To prepare the veggies: In a large skillet over medium heat, warm the olive oil. Once shimmering, add the carrots, bell pepper, zucchini, yellow onion, and salt. Cook, stirring every couple of minutes, until the veggies are golden on the edges, about 8 to 12 minutes. This is just random text please dont take this as what is going to go in our recipe app thank you verymcuh for your kind words _________________________________________________________________________________________________--________________________------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------_________________________________________________________________________________________________--________________________------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------_________________________________________________________________________________________________--________________________------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------_________________________________________________________________________________________________--________________________------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------_________________________________________________________________________________________________--________________________------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------",
                       description: "Lovely Vegetable Lasagne", Ing: ["meadows mushrooms shiitake","fresh produce rockmelon whole","taylor farms salad kit buffalo ranch with dressing"], Quants: [1,1,2], Serving: 4,Image: "Lasagne")
        
        Data.addRecipe(n: "Pumpkin Soup", method: "To prepare the veggies: In a large skillet over medium heat, warm the olive oil. Once shimmering, add the carrots, bell pepper, zucchini, yellow onion, and salt. Cook, stirring every couple of minutes, until the veggies are golden on the edges, about 8 to 12 minutes.",
                       description: "Hearty Soup", Ing: ["fresh produce pumpkin butternut cut","superb herb chives fresh","fresh produce cabbage savoy half"], Quants: [1,2,1], Serving: 3, Image: "PumpkinSoup")
        
        Data.addRecipe(n: "Salad", method: "To prepare the veggies: In a large skillet over medium heat, warm the olive oil. Once shimmering, add the carrots, bell pepper, zucchini, yellow onion, and salt. Cook, stirring every couple of minutes, until the veggies are golden on the edges, about 8 to 12 minutes.",
                       description: "A nice continental Salad", Ing: ["countdown salad thai","countdown salad continental mix"], Quants: [1,1], Serving: 6, Image: "Salad")
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            let vc2 = self.storyboard?.instantiateViewController(identifier: "HomePage") as! HomePageViewController
            self.navigationController?.pushViewController(vc2,animated: false)
            
        }
        
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
