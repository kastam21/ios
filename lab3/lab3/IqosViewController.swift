//
//  IqosViewController.swift
//  lab3
//
//  Created by Astam Kurbanov on 3/6/20.
//  Copyright © 2020 kbtu. All rights reserved.
//
import UIKit

class IqosViewController: UIViewController {
    
    @IBOutlet weak var width: UITextField!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var x: UITextField!
    @IBOutlet weak var y: UITextField!
    
    @IBOutlet var buttons: [UIButton]!
    
    var color: UIColor?
    var square: UIView?
    
    @IBAction func colorPicked(_ sender: UIButton) {
        
        buttons.forEach {(button) in
            if button == sender {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
        
        guard let squareСolor = sender.backgroundColor else {return}
        color = squareСolor
    }
    
    var addSquare: ((_ width: Double, _ height: Double, _ x: Double, _ y: Double, _ color: UIColor) -> Void)? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        
        let delete = UIBarButtonItem(title: "delete", style: .plain, target: self, action: #selector(deleteFunc))
        let add = UIBarButtonItem(title: "save", style: .plain, target: self, action: #selector(save))
        
        guard let square = square else {
             navigationItem.rightBarButtonItems = [ add]
            return
        }
        navigationItem.rightBarButtonItems = [delete, add]
        
        self.width.text = square.frame.width.description
        self.height.text = square.frame.height.description
        self.x.text = square.frame.origin.x.description
        self.y.text = square.frame.origin.y.description
        
        buttons.forEach {(button) in
            if button.backgroundColor == square.backgroundColor {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
        
    }
    
    @objc func save() {
        
        guard let width = width.text, let height = height.text, let x = x.text, let y = y.text, let color = color else {
            let alert = UIAlertController(title: "", message: "data is missing!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        guard let widthNew = Double(width), let heightNew = Double(height), let xNew = Double(x), let yNew = Double(y) else {
            return
        }
        
        guard let square = square else {
            addSquare?(widthNew, heightNew, xNew, yNew, color)
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        square.backgroundColor = color
        square.frame = CGRect(x: CGFloat(xNew), y: CGFloat(yNew), width: CGFloat(widthNew), height: CGFloat(heightNew))
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteFunc() {
        guard let square = square else {return}
        square.removeFromSuperview()
        self.navigationController?.popViewController(animated: true)
    }
    
}

