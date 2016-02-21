//
//  BoardView.swift
//  NQueensVisualize
//
//  Created by xinye lei on 16/2/15.
//  Copyright © 2016年 xinye lei. All rights reserved.
//

import UIKit

class BoardView: UIView {
    
    
    var solution: [Int]? {
        didSet {
            if (solution != nil) {
                self.setNeedsDisplay()
            }
        }
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        if (self.solution != nil) {
            let size = self.solution!.count
            let length = self.bounds.size.width / CGFloat(size)
            let origin = self.bounds.origin
            UIColor.blackColor().setStroke()
            UIColor.blackColor().setFill()
            for (var row = 0; row < size; row++) {
                for (var column = 0; column < size; column++) {
                    let path = UIBezierPath()
                    let currentOrigin = CGPointMake(origin.x + CGFloat(column) * length, origin.y + CGFloat(row) * length)
                    let p1 = currentOrigin, p2 = CGPointMake(currentOrigin.x + length, currentOrigin.y), p3 = CGPointMake(currentOrigin.x + length, currentOrigin.y + length), p4 = CGPointMake(currentOrigin.x, currentOrigin.y + length)
                    path.moveToPoint(p1)
                    path.addLineToPoint(p2)
                    path.addLineToPoint(p3)
                    path.addLineToPoint(p4)
                    path.closePath()
                    path.stroke()
                    if (solution![row] == column) {
                        path.fill()
                    }
                }
            }
        }
    }


}
