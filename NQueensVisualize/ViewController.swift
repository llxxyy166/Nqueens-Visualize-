//
//  ViewController.swift
//  NQueensVisualize
//
//  Created by xinye lei on 16/2/15.
//  Copyright © 2016年 xinye lei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var boardView: BoardView!

    @IBOutlet weak var solutionLabel: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!

    @IBOutlet weak var slider: UISlider!

    @IBOutlet weak var sizeButton: UIButton!
    
    @IBOutlet weak var calculatingLabel: UILabel!
    var currentSize: Int = 1
    
    @IBAction func changeSize(sender: UIStepper) {
        let size = Int(sender.value)
        self.sizeButton.setTitle("n = \(size)", forState: UIControlState.Normal)
        if(size != currentSize) {
            self.sizeButton.backgroundColor = UIColor.redColor()
        }
        else {
            self.sizeButton.backgroundColor = UIColor.clearColor()
        }
    }
    @IBAction func setNewSize(sender: UIButton) {
        let calQ = dispatch_queue_create("calc", nil)!
        self.calculatingLabel.hidden = false
        dispatch_async(calQ) { () -> Void in
            self.calculatingLabel.hidden = false
            let size = Int(self.stepper.value)
            let sols = solveNQueens(size)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.solutions = sols
                if (sols.count == 0) {
                    self.boardView.solution = [Int]()
                }
                sender.backgroundColor = UIColor.clearColor()
                self.currentSize = size
            })
        }
        
    }
    
    @IBAction func changeSolution(sender: UISlider) {
        let index = Int(sender.value)
        self.boardView.solution = self.solutions![index]
        self.solutionLabel.text = "Solution: \(index + 1)/\(solutions!.count)"
    }

    var solutions: [[Int]]? {
        didSet {
            self.calculatingLabel.hidden = true
            self.slider.minimumValue = 0
            self.slider.maximumValue = Float(solutions!.count - 1)
            self.slider.value = 0
            if (solutions!.count > 0) {
                self.boardView.solution = solutions![0]
                self.solutionLabel.text = "Solution: \(1)/\(solutions!.count)"
                self.slider.enabled = true
            }
            else {
                self.solutionLabel.text = "No Solution"
                self.slider.enabled = false
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stepper.minimumValue = 1
        self.stepper.maximumValue = 14
        self.stepper.stepValue = 1
        self.stepper.value = 1
        let sols = solveNQueens(1)
        self.solutions = sols
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

