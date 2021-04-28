//
//  SudokuChecker.swift
//  Simple Sudoku
//
//  Created by aku pintar indonesia on 28/04/21.
//

import Foundation

class SudokuChecker {
    
    
}

// MARK: VALID CHECKING
extension SudokuChecker {
    
    func isValid(grid: [[Int]]) -> Bool {
        let inRow = validRow(grid: grid)
        let inColumn = validColumn(grid: grid)
        let inSquare = validSquare(grid: grid)
        return true
    }
    
    private func validRow(grid: [[Int]]) -> Bool {
        for i in 0..<9 {
            let row = grid[i].filter { $0 != 0}
            print(row)
        }
        print("\n")
        return true
    }
    
    private func validColumn(grid: [[Int]]) -> Bool {
        for i in 0..<9 {
            var column = [Int]()
            for j in 0..<9 {
                column.append(grid[j][i])
            }
            column = column.filter { $0 != 0 }
            print(column)
        }
        print("\n")
        return true
    }
    
    private func validSquare(grid: [[Int]]) -> Bool {
        let start = [0, 3, 6]
        for i in start {
            for j in start {
                var square = [Int]()
                
                for x0 in i...i+2 {
                    for y0 in j...j+2 {
                        square.append(grid[x0][y0])
                    }
                }
                
                square = square.filter { $0 != 0 }
                print(square)
            }
        }
        return true
    }
    
}
