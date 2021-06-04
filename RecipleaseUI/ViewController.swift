//
//  ViewController.swift
//  RecipleaseUI
//
//  Created by Samuel Royal on 1/06/21.
//  Copyright © 2021 Samuel Royal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var field1 : UITextField!
    @IBOutlet var field2 : UITextField!
    @IBOutlet var button : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonTapped(){
    RecipeView()
    }

}

