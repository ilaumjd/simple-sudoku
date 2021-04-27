//
//  SudokuSolver.swift
//  Simple Sudoku
//
//  Created by aku pintar indonesia on 27/04/21.
//

import Foundation

struct EmptyCell {
    
    var row: Int
    var column: Int
    var possibleValues: [Int]
    
}

class SudokuSolver {
    
    var emptyCells = [EmptyCell]()
    
    func solve(grid: [[Int]]) {
        for i in 0..<9 {
            for j in 0..<9 {
                if grid[i][j] == 0 {
                    let possibleValues = (1...9).filter { number in
                        let b = possible(grid: grid, row: i, column: j, number: number)
                        return b
                    }
                    print(" ", i, j, possibleValues)
                    emptyCells.append(EmptyCell(row: i, column: j, possibleValues: possibleValues))
                }
            }
        }
    }
    
    func possible(grid: [[Int]], row: Int, column: Int, number: Int) -> Bool {
        let inRow = possibleInRow(grid: grid, row: row, number: number)
        let inColumn = possibleInColumn(grid: grid, column: column, number: number)
        let inSquare = possibleInSquare(grid: grid, row: row, column: column, number: number)
        return inRow && inColumn && inSquare
    }
    
    func possibleInRow(grid: [[Int]], row: Int, number: Int) -> Bool {
        for i in 0..<9 {
            if grid[row][i] == number {
                return false
            }
        }
        return true
    }
    
    func possibleInColumn(grid: [[Int]], column: Int, number: Int) -> Bool {
        for i in 0..<9 {
            if grid[i][column] == number {
                return false
            }
        }
        return true
    }
    
    func possibleInSquare(grid: [[Int]], row: Int, column: Int, number: Int) -> Bool {
        let x0 = row / 3 * 3
        let y0 = column / 3 * 3
        for i in 0...2 {
            for j in 0...2 {
                if grid[x0+i][y0+j] == number {
                    print(i, j, number)
                    return false
                }
            }
        }
        return true
    }
    
}
