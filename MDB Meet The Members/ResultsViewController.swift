//
//  ResultsViewController.swift
//  MDB Meet The Members
//
//  Created by Rini Vasan on 2/6/20.
//  Copyright © 2020 Rini Vasan. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var imageShowed: UIImageView!
      
    
    @IBOutlet weak var Button1: UIButton!
    
    @IBOutlet weak var Button2: UIButton!
    
    @IBOutlet weak var Button3: UIButton!
    
    @IBOutlet weak var Button4: UIButton!
    
    @IBOutlet weak var scoreButton: UILabel!
    
    @IBOutlet weak var timerNumber: UILabel!
    
    
    
    
    var shuffledNames: [String]?
    
    var randomNames: ArraySlice<String>?
    
    var imageName: String?
    
    var correctAnswer: UIButton?

    var scoreUpdate: Int? = 0
    
    @IBOutlet weak var pauseButton: UIButton!
    
    var seconds = 5
    var timer = Timer()
    var isTimerRunning = false
    var isPaused = false

    var longestStreak = 0
    var currentStreak = 0
    var previousAnswers: [String]? = []
    
    @IBAction func statisticsButtonPressed(_ sender: Any) {
        
        if !isPaused {
            pauseButtonPressed(self)
        }
        
        self.performSegue(withIdentifier: "toStatisticsVC", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toStatisticsVC"{

            let statsVC = segue.destination as? StatisticsVC
            
            statsVC?.longestStreak = self.longestStreak
            
            statsVC?.previousAnswers = self.previousAnswers
        }
    }
    
    
    
    
    @IBAction func pauseButtonPressed(_ sender: Any) {
        
       if self.isPaused == false {
            Button1.isUserInteractionEnabled = false
            Button2.isUserInteractionEnabled = false
            Button3.isUserInteractionEnabled = false
            Button4.isUserInteractionEnabled = false
            timer.invalidate()
            self.isPaused = true
            self.pauseButton.setTitle("Resume", for:.normal)
        } else {
            Button1.isUserInteractionEnabled = true
            Button2.isUserInteractionEnabled = true
            Button3.isUserInteractionEnabled = true
            Button4.isUserInteractionEnabled = true
             runTimer()
             self.isPaused = false
             self.pauseButton.setTitle("Pause", for:.normal)
        }
    }
    
    func last3Questions(){
        
        
    }
    
   func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ResultsViewController.updateTimer)), userInfo: nil, repeats: true)
        timerNumber.text = timeString(time: TimeInterval(seconds))
         isTimerRunning = true
         pauseButton.isEnabled = true
    }
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            noAnswerPicked()
             //Send alert to indicate "time's up!"
        } else {
             seconds -= 1
             timerNumber.text = timeString(time: TimeInterval(seconds))
        }

    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format: "%02d: %02d: %02d", hours, minutes, seconds)
        
    }
    
    func noAnswerPicked(){
        // if no answer is picked, mark all of them red except the right answer green
        // display the red/green buttons for one second
        // generate next image
        
        for button in [Button1, Button2, Button3, Button4] {
            if imageName == button?.titleLabel?.text {
                button?.backgroundColor = .green
            }
            else if imageName != button?.titleLabel?.text{
                button?.backgroundColor = .red
                correctAnswer?.backgroundColor = .green
            }
        }
        let temp = correctAnswer

        
        //insert timer here
        timer.invalidate()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {timer in        self.generateRandomImagesAndButtons()})
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { timer in
            for button in [self.Button1, self.Button2, self.Button3, self.Button4] {
                button?.backgroundColor = .white
                temp?.backgroundColor = .white
            }
         }
        )
        seconds = 5
        runTimer()
         
    }
    

    func generateRandomImagesAndButtons(){
        
            shuffledNames = Constants.names.shuffled()
            if shuffledNames != nil {
                randomNames = shuffledNames![0..<4]
            }
            
            if randomNames != nil{
                imageName = randomNames?.shuffled()[0]
            }
            for i in 0..<randomNames!.count {
                if randomNames![i] == imageName!{
                    if i == 0{
                        correctAnswer = Button1
                    }
                    if i == 1{
                        correctAnswer = Button2
                    }
                    if i == 2{
                        correctAnswer = Button3
                    }
                    if i == 3{
                        correctAnswer = Button4
                    }
                }
            }
    
        
        
            Button1.setTitle(randomNames?[0], for: .normal)

            Button2.setTitle(randomNames?[1], for: .normal)

            Button3.setTitle(randomNames?[2], for: .normal)

            Button4.setTitle(randomNames?[3], for: .normal)

            imageShowed.image = Constants.getImageFor(name: imageName!)
            
            
            Button1.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            Button2.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            Button3.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            Button4.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            
        }
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseButton.isEnabled = false
    
        scoreButton.text = "Score: \(scoreUpdate!)"
        
        Button1.isUserInteractionEnabled = true
        Button2.isUserInteractionEnabled = true
        Button3.isUserInteractionEnabled = true
        Button4.isUserInteractionEnabled = true
        if isTimerRunning == false {
           seconds = 5
            runTimer()
       }
        

        // Do any additional setup after loading the view.
     
        // For the buttons: get 4 randomized names
        generateRandomImagesAndButtons()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isPaused {
            pauseButtonPressed(self)
        }
    }
    
    
    //Get an image that matches with one of the 4 randomized names
    
    // For the correct button- make it green
       
    //Update score
       
    //For the incorrect button- make it red and the correct answer should be green
    
    @objc func buttonPressed(_ sender: UIButton){
            
        if imageName == sender.titleLabel?.text{
            sender.backgroundColor = .green
            scoreUpdate! += 1
            scoreButton.text = "Score: \(scoreUpdate!)"
            currentStreak += 1
            if currentStreak > longestStreak{
                longestStreak = currentStreak
            }
            
            if let currAnswer = imageName {
                previousAnswers?.append(currAnswer)
                if previousAnswers?.count ?? 0 > 3 {
                    previousAnswers?.removeFirst()
                }
            }
            
            
        }
        
        else if imageName != sender.titleLabel?.text{
            sender.backgroundColor = .red
            currentStreak = 0
            
            //the image name that equals button text should be green
            correctAnswer?.backgroundColor = .green
            
            if let currAnswer = imageName {
                previousAnswers?.append(currAnswer)
                if previousAnswers?.count ?? 0 > 3 {
                    previousAnswers?.removeFirst()
                }
            }
        }
        
        let temp = correctAnswer
        
        //insert timer here
        timer.invalidate()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {timer in        self.generateRandomImagesAndButtons()})
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {
            timer in sender.backgroundColor = .white
            temp?.backgroundColor = .white
        })
        seconds = 5
        runTimer()

        //Re-randomize new picture and buttons
        //generateRandomImagesAndButtons()
        }
        

    
    
    
    
   
    
    //One second delay in between next picture shown
    
    

    //Implement a timer
    
  



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
