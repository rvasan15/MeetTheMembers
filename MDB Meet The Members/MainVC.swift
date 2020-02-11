//
//  ViewController.swift
//  MDB Meet The Members
//
//  Created by Rini Vasan on 2/6/20.
//  Copyright © 2020 Rini Vasan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var startButtonPressed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func toResultsVC(_ sender: Any) {
        self.performSegue(withIdentifier: "toResultsVC", sender: self)
    }
    
    
   
    
    
}

