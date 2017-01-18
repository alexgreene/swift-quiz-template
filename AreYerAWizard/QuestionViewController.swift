//
//  QuestionViewController.swift
//  AreYerAWizard
//
//  Created by Alex Greene on 6/7/16.
//  Copyright © 2016 AlexGreene. All rights reserved.
//

import Foundation
import UIKit
import MessageUI
import AVFoundation
import GameplayKit

class QuestionViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var questionText: UITextView!
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    
    @IBOutlet weak var soundtrackSubtext: UITextView!
    
    var menuStatus = 0
    // 0 : question
    // 1 : main menu
    // 2 : soundtrack
    
    var audioPlayer: AVAudioPlayer! = nil
    
    @IBOutlet weak var currentRankingLabel: UILabel!
    @IBOutlet weak var percentAccuracyLabel: UILabel!
    @IBOutlet weak var percentCompletedLabel: UILabel!
    
    let colors = [
        ["6D0106", "BA0911", "FF2828", "EAB912"], ["FDE358", "76819F", "3E4154", "615420"],
        ["678282", "383A3D", "B9C3AA", "E6AE00"], ["23470A", "4D931D", "BCE0A4", "B0B0B0"]
    ]
    
    var webView:UIWebView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuStatus = 0
        loadCurrentQuestion()
        menuButton.setTitle("ℹ️", for: UIControlState())
        
        menuButton.layer.cornerRadius = 25
        soundtrackSubtext.isHidden = true
        
        currentRankingLabel.isHidden = true
        percentAccuracyLabel.isHidden = true
        percentCompletedLabel.isHidden = true
    }
    
    func playSound(_ name: String, type: String, volume: Float) {
        let path = Bundle.main.path(forResource: name, ofType: type)
        let fileURL = URL(fileURLWithPath: path!)
        
        do {
            try self.audioPlayer =  AVAudioPlayer(contentsOf: fileURL)
        } catch {
            print("error")
        }
        self.audioPlayer.volume = volume
        self.audioPlayer.prepareToPlay()
        self.audioPlayer.play()
    }

    @IBAction func buttonA_click(_ sender: AnyObject) {
        if menuStatus == 1 { // SOUNDTRACK MENU ITEM SELECTED
            buttonA.setTitle("Soundtrack A", for: UIControlState())
            buttonB.setTitle("Soundtrack B", for: UIControlState())
            buttonC.setTitle("Soundtrack C", for: UIControlState())
            buttonD.setTitle("◁ Previous Menu", for: UIControlState())
            questionText.text = "1. Choose a link & play video\n2. Return to this app\n3. Swipe up from bottom of screen to open settings, press ▶︎"
            menuStatus = 2
            menuButton.isHidden = true
            pulseButtonsInward()
            setStatisticsHidden(true)
        }
        else if menuStatus == 2 {
            // LINK A SELECTED
            UIApplication.shared.openURL(URL(string:"https://www.youtube.com/watch?v=uKFt7-VISYQ")!)
        }
        else if menuStatus == 0 { // ANSWERED QUESTION
            respond(QuestionBank.questionBank.submitAnswerForCurrentQuestion(buttonA.titleLabel?.text))
            loadNewQuestion()
        }
    }
    
    @IBAction func buttonB_click(_ sender: AnyObject) {
        if menuStatus == 1 {
            // SUBMIT QUESTION MENU ITEM SELECTED
            let picker = MFMailComposeViewController()
            picker.mailComposeDelegate = self
            picker.setSubject("New Question Suggestion ⚡️")
            picker.setToRecipients(["alexgrn7@gmail.com"])
            //picker.setMessageBody(, isHTML: true)
            
            present(picker, animated: true, completion: nil)
        }
        else if menuStatus == 2 {
            // LINK B SELECTED
            UIApplication.shared.openURL(URL(string:"https://www.youtube.com/watch?v=0q6nDCDHIvg")!)
        }
        else if menuStatus == 0 { // ANSWERED QUESTION
            respond(QuestionBank.questionBank.submitAnswerForCurrentQuestion(buttonB.titleLabel?.text))
            loadNewQuestion()
        }
    }
    
    @IBAction func buttonC_click(_ sender: AnyObject) {
        if menuStatus == 2 {
            // LINK C SELECTED
            UIApplication.shared.openURL(URL(string:"https://www.youtube.com/watch?v=RwbUelCSVFs")!)
        }
        else if menuStatus == 0 { // ANSWERED QUESTION
            respond(QuestionBank.questionBank.submitAnswerForCurrentQuestion(buttonC.titleLabel?.text))
            loadNewQuestion()
        }
        else if menuStatus == 1 {
            UIApplication.shared.openURL(URL(string:"https://www.twitter.com/pottermorefans")!)
        }
    }
    
    @IBAction func buttonD_click(_ sender: AnyObject) {
        if menuStatus > 1 {
            // BACK BUTTON SELECTED
            buttonA.setTitle("🎵 Soundtrack", for: UIControlState())
            buttonB.setTitle("📝 Submit a Question", for: UIControlState())
            buttonC.setTitle("@pottermorefans", for: UIControlState())
            buttonD.setTitle("2016 A.G.", for: UIControlState())
            menuButton.setTitle("▶️", for: UIControlState())
            questionText.text = "Are Yer A Wizard?"
            menuStatus = 1
            self.webView.removeFromSuperview()
            menuButton.isHidden = false
            soundtrackSubtext.isHidden = true
            setStatisticsHidden(false)
            pulseButtonsInward()
        }
        else if menuStatus == 0 { // ANSWERED QUESTION
            respond(QuestionBank.questionBank.submitAnswerForCurrentQuestion(buttonD.titleLabel?.text))
            loadNewQuestion()
        }
    }
    
    @IBAction func menuButtonClicked(_ sender: AnyObject) {
        
        //playSound("shuffle", type: "wav", volume: 1.0)
        
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            (sender as! UIView).transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        })
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            (sender as! UIView).transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
        
        pulseButtonsInward()

        if menuStatus == 0 {
            buttonA.setTitle("🎵 Soundtrack", for: UIControlState())
            buttonB.setTitle("📝 Submit a Question", for: UIControlState())
            buttonC.setTitle("@pottermorefans", for: UIControlState())
            buttonD.setTitle("2016 A.G.", for: UIControlState())
            menuButton.setTitle("▶️", for: UIControlState())
            questionText.text = "Are Yer A Wizard?"
            menuStatus = 1
            menuButton.isHidden = false
            setStatisticsHidden(false)
        }
        else {
            loadCurrentQuestion()
            (sender as! UIButton).setTitle("ℹ️", for: UIControlState())
            menuStatus = 0
            setStatisticsHidden(true)
        }
    }
    
    func setStatisticsHidden(_ val: Bool) {
        currentRankingLabel.isHidden = val
        percentAccuracyLabel.isHidden = val
        percentCompletedLabel.isHidden = val
        
        if val == false {
            let pa = QuestionBank.questionBank.getAccuracy()
            percentAccuracyLabel.text = (pa >= 0) ? String(QuestionBank.questionBank.getAccuracy()) + "% magical accuracy" : "no magical accuracy yet"

            percentCompletedLabel.text = String(QuestionBank.questionBank.getJourneyCompletion()) + "% of journey completed"
            
            currentRankingLabel.text = "You are currently ranked as " + QuestionBank.questionBank.getRanking()
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
    func loadNewQuestionHeavyLifting() {
        let q = QuestionBank.questionBank.getNextQuestion()
        if (q.a != nil) {
            
            var set = [q.a, q.b, q.c, q.correct]
            set = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: set) as! [String?]
            applyNewColors()
            questionText.text = q.text
            
            buttonA.setTitle(set[0], for: UIControlState())
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                (self.buttonA as UIView).transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            })
            
            UIView.animate(withDuration: 0.4, animations: { () -> Void in
                (self.buttonA as UIView).transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
            
            buttonB.setTitle(set[1], for: UIControlState())
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                (self.buttonB as UIView).transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            })
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                (self.buttonB as UIView).transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
            
            buttonC.setTitle(set[2], for: UIControlState())
            UIView.animate(withDuration: 0.4, animations: { () -> Void in
                (self.buttonC as UIView).transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            })
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                (self.buttonC as UIView).transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
            
            buttonD.setTitle(set[3], for: UIControlState())
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                (self.buttonD as UIView).transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            })
            
            UIView.animate(withDuration: 0.7, animations: { () -> Void in
                (self.buttonD as UIView).transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        }
    }
    
    func loadNewQuestion() {
        if QuestionBank.questionBank.hasBeenCompleted() {
            let msg = "Your " + String(QuestionBank.questionBank.getAccuracy(1)) + "% accuracy earned you\nthe honorable rank of " + String(QuestionBank.questionBank.getRanking()) + ".\nYour game will now reset."
            let alert = UIAlertController(title: "You've completed your journey!", message: msg, preferredStyle: .actionSheet)
            
            let ResetAction = UIAlertAction(title: "Onward", style: .destructive) { (action) in
                self.loadNewQuestionHeavyLifting()
            }
            alert.addAction(ResetAction)
            
            alert.popoverPresentationController?.sourceView = self.view
            alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width / 2.0, y: self.view.bounds.size.height / 2.0, width: 1.0, height: 1.0)
            self.present(alert, animated: true, completion: nil)
        }
        else {
            loadNewQuestionHeavyLifting()
        }
    }
    
    func loadCurrentQuestion() {
        let q = QuestionBank.questionBank.getCurrentQuestion()
        if (q.a != nil) {
            
            var set = [q.a, q.b, q.c, q.correct]
            set = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: set) as! [String?]

            
            questionText.text = q.text
            buttonA.setTitle(set[0], for: UIControlState())
            buttonB.setTitle(set[1], for: UIControlState())
            buttonC.setTitle(set[2], for: UIControlState())
            buttonD.setTitle(set[3], for: UIControlState())
        }
    }
    
    func pulseButtonsInward() {
        
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            (self.buttonA as UIView).transform = CGAffineTransform(scaleX: 0.0, y: 1.0)
        })
        
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            (self.buttonA as UIView).transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            (self.buttonB as UIView).transform = CGAffineTransform(scaleX: 0.0, y: 1.0)
        })
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            (self.buttonB as UIView).transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
        
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            (self.buttonC as UIView).transform = CGAffineTransform(scaleX: 0.0, y: 1.0)
        })
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            (self.buttonC as UIView).transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            (self.buttonD as UIView).transform = CGAffineTransform(scaleX: 0.0, y: 1.0)
        })
        
        UIView.animate(withDuration: 0.7, animations: { () -> Void in
            (self.buttonD as UIView).transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func respond(_ b: Bool) {
        if b == true {
            correct()
        }
        else {
            incorrect()
        }
    }
    
    func incorrect() {
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            (self.questionText as UIView).shake()
        })
    }
    
    func correct() {
        
    }
    
    func applyNewColors() {
        let s = Int(arc4random_uniform(4))
        
        buttonA.backgroundColor = colorWithHexString(colors[s][0])
        buttonB.backgroundColor = colorWithHexString(colors[s][1])
        buttonC.backgroundColor = colorWithHexString(colors[s][2])
        buttonD.backgroundColor = colorWithHexString(colors[s][3])
    }
    
    func colorWithHexString (_ hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
}

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
