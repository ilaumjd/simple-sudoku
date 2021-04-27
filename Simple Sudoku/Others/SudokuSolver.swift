//
//  SudokuSolver.swift
//  Simple Sudoku
//
//  Created by aku pintar indonesia on 27/04/21.
//

import Foundation

class SudokuSolver {
    
    func solve(grid: [[Int]]) {
        var newGrid = grid
        var possibleValues = generateStartingPossibleValues(grid: grid)
        var singlePossibility = true
        
        while singlePossibility {
            
            singlePossibility = false
            
            for i in 0..<9 {
                for j in 0..<9 {
                    if newGrid[i][j] == 0 {
                        
                        possibleValues[i][j] = possibleValues[i][j].filter { number in
                            possible(grid: newGrid, row: i, column: j, number: number)
                        }
                        
                        if possibleValues[i][j].count == 1 {
                            newGrid[i][j] = possibleValues[i][j][0]
                            possibleValues[i][j] = []
                            singlePossibility = true
                        }
                        
                    }
                }
            }
            
            print(possibleValues)
            print(newGrid, "\n")
            
        }
    }
    
    func generateStartingPossibleValues(grid: [[Int]]) -> [[[Int]]] {
        var possibleValues = [[[Int]]]()
        for i in 0..<9 {
            var possibleValuesInRow = [[Int]]()
            for j in 0..<9 {
                if grid[i][j] == 0 {
                    possibleValuesInRow.append(Array(1...9))
                } else {
                    possibleValuesInRow.append([])
                }
            }
            possibleValues.append(possibleValuesInRow)
        }
        return possibleValues
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
                    return false
                }
            }
        }
        return true
    }
    
}
