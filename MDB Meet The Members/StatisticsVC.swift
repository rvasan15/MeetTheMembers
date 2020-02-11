//
//  StatisticsVC.swift
//  MDB Meet The Members
//
//  Created by Rini Vasan on 2/7/20.
//  Copyright © 2020 Rini Vasan. All rights reserved.
//

import UIKit

class StatisticsVC: UIViewController {

    var longestStreak: Int?
    var previousAnswers: [String]?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        longestStreakLabel.text = "Longest Streak: \(longestStreak ?? 0)"
//        resultsOfLast3.text = """
//            Results of last 3 Questions:
//        \(previousAnswers?[0] ?? "")
//        \(previousAnswers?[1] ?? "")
//        \(previousAnswers?[2] ?? "")
//        """
        if previousAnswers?.count == 3{
            answer1Label.text = previousAnswers?[0]
            answer2Label.text = previousAnswers?[1]
            answer3Label.text = previousAnswers?[2]

        }
        if previousAnswers?.count == 2{
            answer1Label.text = previousAnswers?[0]
            answer2Label.text = previousAnswers?[1]
            answer3Label.text = ""
        }
        if previousAnswers?.count == 1{
            answer1Label.text = previousAnswers?[0]
            answer2Label.text = ""
            answer3Label.text = ""
        }

        if previousAnswers?.count == 0{
        answer1Label.text = ""
        answer2Label.text = ""
        answer3Label.text = ""
    }
}
    

    @IBOutlet weak var longestStreakLabel: UILabel!
    
    @IBOutlet weak var resultsOfLast3: UILabel!
    
    @IBOutlet weak var answer1Label: UILabel!
    @IBOutlet weak var answer2Label: UILabel!
    @IBOutlet weak var answer3Label: UILabel!
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
