//
//  ViewController.swift
//  calculatorIOS
//
//  Created by Astam Kurbanov on 2/1/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let calculator = Calculator()
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func numberPressed(_ sender: UIButton) {
        guard let numberText = sender.titleLabel?.text else { return }
        if resultLabel.text == "0" || resultLabel.text == "0.0"  {
            resultLabel.text = ""
        }
        resultLabel.text?.append(contentsOf: numberText)
        
    }
    
    @IBAction func operationPressed(_ sender: UIButton) {
        guard
            let numberText = resultLabel.text,
            let number = Double(numberText),
            let operation = sender.titleLabel?.text
        else {
            return
            
        }
        
        resultLabel.text = "0.0"
        
        calculator.setOperands(number: number)
        calculator.execute(symbol: operation)
        
        if(canShow(op: operation)){
            resultLabel.text = String(calculator.result)
        }

    }
    
    func canShow(op: String) -> Bool{
        if(op != "+" && op != "-" && op != "/" && op != "x" && op != "x^y"){
            return true
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    


}
