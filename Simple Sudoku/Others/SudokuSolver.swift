//
//  SudokuSolver.swift
//  Simple Sudoku
//
//  Created by aku pintar indonesia on 27/04/21.
//

import Foundation

class SudokuSolver {
    
    private var stopBacktracking = false
    
    func solve(grid: [[Int]], completion: @escaping (([[Int]]) -> ()), failed: @escaping (() -> ())) {
        let possibleValues = generateStartingPossibleValues(grid: grid)
        
        print("---------------- SINGLE POSSIBILITY ----------------\n")
        var (newGrid, newPossibleValues, solved, invalid) = solveBySinglePossibility(grid: grid, possibleValues: possibleValues)
        
        if invalid {
            failed()
            return
        }
        
        if !solved {
            print("---------------- BACKTRACKING ----------------\n")
            let (lastRow, lastColumn) = lastIndex(possibleValues: newPossibleValues)
            newGrid = solveByBacktracking(grid: newGrid, possibleValues: newPossibleValues, lastRow: lastRow, lastColumn: lastColumn)
            print(newGrid)
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
    
    private func solveByBacktracking(grid: [[Int]], possibleValues: [[[Int]]], lastRow: Int, lastColumn: Int) -> [[Int]] {
        var newGrid = grid
        
        for i in 0..<9 {
            for j in 0..<9 {
                if newGrid[i][j] == 0 {
                    for number in possibleValues[i][j] {
                        if possible(grid: newGrid, row: i, column: j, number: number) {
                            newGrid[i][j] = number
                            if i == lastRow && j == lastColumn {
                                self.stopBacktracking = true
                                return newGrid
                            }
                            let tempGrid = solveByBacktracking(grid: newGrid, possibleValues: possibleValues, lastRow: lastRow, lastColumn: lastColumn)
                            if stopBacktracking {
                                return tempGrid
                            }
                        }
                    }
                }
            }
        }
        return []
    }
    
    private func lastIndex(possibleValues: [[[Int]]]) -> (Int, Int) {
        for i in (0..<9).reversed() {
            for j in (0..<9).reversed() {
                if !possibleValues[i][j].isEmpty {
                    return (i,j)
                }
            }
        }
        return (0,0)
    }
    
}

// MARK: SINGLE POSSIBILITY
extension SudokuSolver {
    
    private func solveBySinglePossibility(grid: [[Int]], possibleValues: [[[Int]]]) -> ([[Int]], [[[Int]]], Bool, Bool) {
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
                        
                        if newPossibleValues[i][j].count == 0 {
                            return(newGrid, newPossibleValues, solved, true)
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
        
        return(newGrid, newPossibleValues, solved, false)
        
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
