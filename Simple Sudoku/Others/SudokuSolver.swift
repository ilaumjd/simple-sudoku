//
//  SudokuSolver.swift
//  Simple Sudoku
//
//  Created by aku pintar indonesia on 27/04/21.
//

import Foundation

class SudokuSolver {
    
    var sudoku: [[Int]]
    
    init(sudoku: [[Int]]) {
        self.sudoku = sudoku
    }
    
    func solve() {
        for i in 0..<9 {
            for j in 0..<9 {
                if self.sudoku[i][j] == 0 {
                    for number in 1...9 {
                        if possible(row: i, column: j, number: number) {
                            self.sudoku[i][j] = number
                            solve()
                            self.sudoku[i][j] = 0
                        }
                    }
                    return
                }
            }
        }
    }
    
    func possible(row: Int, column: Int, number: Int) -> Bool {
        return possibleRow(row: row, number: number)
            && possibleColumn(column: column, number: number)
            && possibleSquare(row: row, column: column, number: number)
    }
    
    func possibleRow(row: Int, number: Int) -> Bool {
        for i in 0..<9 {
            if self.sudoku[row][i] == number {
                return false
            }
        }
        return true
    }
    
    func possibleColumn(column: Int, number: Int) -> Bool {
        for i in 0..<9 {
            if self.sudoku[i][column] == number {
                return false
            }
        }
        return true
    }
    
    func possibleSquare(row: Int, column: Int, number: Int) -> Bool {
        let x0 = column / 3 * 3
        let y0 = row / 3 * 3
        for i in x0..<x0+3 {
            for j in y0..<y0+3 {
                if self.sudoku[i][j] == number {
                    return false
                }
            }
        }
        return true
    }
    
}
