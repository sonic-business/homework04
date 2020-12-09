//
//  GameScreenViewController.swift
//  homework04
//
//  Created by student on 2020/11/30.
//  Copyright © 2020 student. All rights reserved.
//

import GameplayKit
import UIKit

class GameScreenViewController: UIViewController {

    @IBOutlet weak var guessLabel: UILabel!
    @IBOutlet weak var resultTextview: UITextView!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var btnEnter: UIButton!

    var cumulativeFrequency: Int = 0;
    var correctAnswer: [String] = ["","","",""]

    enum NumberButtonTag: Int, CaseIterable {
        case value0 = 100
        case value1 = 101
        case value2 = 102
        case value3 = 103
        case value4 = 104
        case value5 = 105
        case value6 = 106
        case value7 = 107
        case value8 = 108
        case value9 = 109

        var btnValue: Int {
            return rawValue - 100
        }
        var btnClass: String {
            return String(describing: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createNumbers()
        resetInputScreen()
    }

    @IBAction func restartPressed(_ sender: UIButton) {
        createNumbers()
        resetInputScreen()
        btnClear.isEnabled = true
    }

    @IBAction func clearPressed(_ sender: UIButton) {
        resetInputScreen()
    }

    @IBAction func enterPressed(_ sender: UIButton) {
        checkNumbers()
    }

    @IBAction func numberInputPressed(_ sender: UIButton) {
        if guessLabel.text!.count < 4 {
            sender.isEnabled = false
            guessLabel.text = guessLabel.text! + String(NumberButtonTag(rawValue: sender.tag)?.btnValue ?? 99)
        }
        if guessLabel.text!.count == 4 {
            btnEnter.isEnabled = true
        }
        //print(NumberButtonTag(rawValue: sender.tag)?.btnValue ?? 99)
        //print(NumberButtonTag(rawValue: sender.tag)?.btnClass ?? 99)
        //print("\(guessLabel.text!.count)   \(guessLabel.text!)")
    }

    func createNumbers() {
        resultTextview.text = "input 4 values"
        cumulativeFrequency = 0
        let randomDistribution = GKShuffledDistribution(lowestValue: 0, highestValue: 9)
        for i in 0...correctAnswer.count-1 {
            correctAnswer[i] = "\(randomDistribution.nextInt())"
        }
        //print(correctAnswer)
    }

    func checkNumbers() {
        var a = 0
        var b = 0
        var i = 0
        for char in guessLabel.text! {
            let number = String(char)
            if correctAnswer[i] == number {
                a += 1
            } else if correctAnswer.contains(number) {
                b += 1
            }
            i += 1
        }

        var guessResult = guessLabel.text!
        if a == 4 {
            disableButton()
            guessResult += "  4A\ncorrect answer\n\n"
        } else {
            resetInputScreen()
            guessResult += "  \(a)A\(b)B\n"
        }

        cumulativeFrequency += 1
        resultTextview.text = "[\(cumulativeFrequency)]  \(guessResult)" + resultTextview.text
    }

    func resetInputScreen() {
        guessLabel.text = ""
        btnEnter.isEnabled = false

        let first = NumberButtonTag.value0.rawValue
        let last = NumberButtonTag.value9.rawValue
        for tagvalue in first...last {
            let btnTemp = self.view.viewWithTag(tagvalue) as! UIButton
            btnTemp.isEnabled = true
        }
    }

    func disableButton() {
        btnClear.isEnabled = false
        btnEnter.isEnabled = false

        let first = NumberButtonTag.value0.rawValue
        let last = NumberButtonTag.value9.rawValue
        for tagvalue in first...last {
            let btnTemp = self.view.viewWithTag(tagvalue) as! UIButton
            btnTemp.isEnabled = false
        }
    }

}
