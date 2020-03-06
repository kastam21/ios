//
//  ViewController.swift
//  lab3
//
//  Created by Astam Kurbanov on 3/6/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(nextView))
    }

    @objc func nextView() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "IqosViewController") as IqosViewController
        
        vc.addSquare = { width, height, x, y, color in
            
            let square = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tap))
            square.addGestureRecognizer(tapGestureRecognizer)
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.pan(recognizer:)))
            square.addGestureRecognizer(panGestureRecognizer)
            
            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.pinch))
            square.addGestureRecognizer(pinchGestureRecognizer)
            
            square.backgroundColor = color
            self.view.addSubview(square)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        if let square = sender.view {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "IqosViewController") as IqosViewController
            vc.square = square
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func pinch(_ sender: UIPinchGestureRecognizer) {
        if let square = sender.view {
            if sender.state == .began || sender.state == .changed {
                square.transform = (square.transform.scaledBy(x: sender.scale, y: sender.scale))
               sender.scale = 1.0
            }
        }
    }
    
    var baseOrigin: CGPoint!
    @objc func pan(recognizer: UIPanGestureRecognizer) {
        if let square = recognizer.view {
            switch recognizer.state {
            case .began:
                baseOrigin = square.frame.origin
            case .changed:
                let d = recognizer.translation(in: square)
                square.frame.origin.x = baseOrigin.x + d.x
                square.frame.origin.y = baseOrigin.y + d.y
            default: break
            }
        }
    }
    
}
