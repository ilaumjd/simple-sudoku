//
//  SudokuChecker.swift
//  Simple Sudoku
//
//  Created by aku pintar indonesia on 28/04/21.
//

import Foundation

class SudokuChecker {
    
    func isValid(grid: [[Int]]) -> Bool {
        let inRow = validRow(grid: grid)
        let inColumn = validColumn(grid: grid)
        let inSquare = validSquare(grid: grid)
        return inRow && inColumn && inSquare
    }
    
    func isSolved(grid: [[Int]]) -> Bool {
        for i in 0..<9 {
            for j in 0..<9 {
                if grid[i][j] == 0 {
                    return false
                }
            }
        }
        return isValid(grid: grid)
    }
    
    
}

// MARK: VALID CHECKING
extension SudokuChecker {
    
    private func validRow(grid: [[Int]]) -> Bool {
        for i in 0..<9 {
            let numbers = grid[i].filter { $0 != 0}
            print(numbers)
            if anyMultipleNumber(numbers: numbers) {
                return false
            }
        }
        print("\n")
        return true
    }
    
    private func validColumn(grid: [[Int]]) -> Bool {
        for i in 0..<9 {
            var numbers = [Int]()
            for j in 0..<9 {
                numbers.append(grid[j][i])
            }
            numbers = numbers.filter { $0 != 0 }
            print(numbers)
            if anyMultipleNumber(numbers: numbers) {
                return false
            }
        }
        print("\n")
        return true
    }
    
    private func validSquare(grid: [[Int]]) -> Bool {
        let start = [0, 3, 6]
        for i in start {
            for j in start {
                var numbers = [Int]()
                
                for x0 in i...i+2 {
                    for y0 in j...j+2 {
                        numbers.append(grid[x0][y0])
                    }
                }
                numbers = numbers.filter { $0 != 0 }
                print(numbers)
                if anyMultipleNumber(numbers: numbers) {
                    return false
                }
            }
        }
        print("\n")
        return true
    }
    
    private func anyMultipleNumber(numbers: [Int]) -> Bool {
        for i in 1...9 {
            let count = numbers.filter({ $0 == i }).count
            if count > 1 {
                print("double \(i) on: \(numbers)\n")
                return true
            }
        }
        return false
    }
    
}
