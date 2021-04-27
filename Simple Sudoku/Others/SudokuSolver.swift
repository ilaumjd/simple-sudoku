//
//  SudokuSolver.swift
//  Simple Sudoku
//
//  Created by aku pintar indonesia on 27/04/21.
//

import Foundation

class SudokuSolver {
    
    func solve(grid: [[Int]], completion: @escaping (([[Int]]) -> ())) {
        let possibleValues = generateStartingPossibleValues(grid: grid)
        
        print("---------------- SINGLE POSSIBILITY ----------------\n")
        let (newGrid, newPossibleValues, solved) = solveBySinglePossibility(grid: grid, possibleValues: possibleValues)
        
        if !solved {
            print("---------------- BACKTRACKING ----------------\n")
            solveByBacktracking(grid: newGrid, possibleValues: newPossibleValues)
        }
        
        completion(newGrid)
    }
    
    private func generateStartingPossibleValues(grid: [[Int]]) -> [[[Int]]] {
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
    
}

// MARK: BACKTRACKING
extension SudokuSolver {
    
    private func solveByBacktracking(grid: [[Int]], possibleValues: [[[Int]]]) {
        var newGrid = grid
        
        for i in 0..<9 {
            for j in 0..<9 {
                if newGrid[i][j] == 0 {
                    for number in possibleValues[i][j] {
                        newGrid[i][j] = number
                        solveByBacktracking(grid: newGrid, possibleValues: possibleValues)
                    }
                }
            }
        }
        print(newGrid, "\n")
    }
    
}

// MARK: SINGLE POSSIBILITY
extension SudokuSolver {
    
    private func solveBySinglePossibility(grid: [[Int]], possibleValues: [[[Int]]]) -> ([[Int]], [[[Int]]], Bool) {
        var newGrid = grid
        var newPossibleValues = possibleValues
        
        var singlePossibility = true
        var solved = false
        
        // fill single possibility
        while singlePossibility {
            
            singlePossibility = false
            solved = true
            
            for i in 0..<9 {
                for j in 0..<9 {
                    
                    if newGrid[i][j] == 0 {
                        
                        solved = false
                        
                        newPossibleValues[i][j] = newPossibleValues[i][j].filter { number in
                            possible(grid: newGrid, row: i, column: j, number: number)
                        }
                        
                        if newPossibleValues[i][j].count == 1 {
                            newGrid[i][j] = newPossibleValues[i][j][0]
                            newPossibleValues[i][j] = []
                            singlePossibility = true
                        }

                    }
                    
                }
            }
            
            print(newGrid)
            print("solved: \(solved) \n")
            
        }
        
        return(newGrid, newPossibleValues, solved)
        
    }
    
}

// MARK: POSSIBLE NUMBER CHECKING
extension SudokuSolver {
    
    private func possible(grid: [[Int]], row: Int, column: Int, number: Int) -> Bool {
        let inRow = possibleInRow(grid: grid, row: row, number: number)
        let inColumn = possibleInColumn(grid: grid, column: column, number: number)
        let inSquare = possibleInSquare(grid: grid, row: row, column: column, number: number)
        return inRow && inColumn && inSquare
    }
    
    private func possibleInRow(grid: [[Int]], row: Int, number: Int) -> Bool {
        for i in 0..<9 {
            if grid[row][i] == number {
                return false
            }
        }
        return true
    }
    
    private func possibleInColumn(grid: [[Int]], column: Int, number: Int) -> Bool {
        for i in 0..<9 {
            if grid[i][column] == number {
                return false
            }
        }
        return true
    }
    
    private func possibleInSquare(grid: [[Int]], row: Int, column: Int, number: Int) -> Bool {
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
