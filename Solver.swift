//
//  Solver.swift
//  NQueensVisualize
//
//  Created by xinye lei on 16/2/15.
//  Copyright © 2016年 xinye lei. All rights reserved.
//

import Foundation

func nQueens(size: Int, _ current: Int, inout _ solution: [Int], inout _ container: [[Int]]) {
    if (current == size) {
        container.append(solution)
        return
    }
    for (var column = 0; column < size; column++) {
        var flag = true
        for (var row = 0; row < current; row++) {
            if (solution[row] == column || abs(row - current) == abs(solution[row] - column)) {
                flag = false
                break
            }
        }
        if (flag) {
            solution[current] = column
            nQueens(size, current + 1, &solution, &container)
        }
    }
}

func solveNQueens(size: Int) -> [[Int]] {
    var container = [[Int]]()
    var solution = [Int](count: size, repeatedValue: 0)
    nQueens(size, 0, &solution, &container)
    return container
}