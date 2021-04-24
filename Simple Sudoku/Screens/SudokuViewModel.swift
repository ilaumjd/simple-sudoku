//
//  SudokuViewModel.swift
//  Simple Sudoku
//
//  Created by aku pintar indonesia on 24/04/21.
//

import Foundation
import RxSwift
import RxCocoa
import PBSudoku

class SudokuViewModel {
    
    private let disposeBag = DisposeBag()
    
    var selectedIndex: Int?
    
    let currentState = BehaviorRelay<[[Int]]>(value: [])
    var defaultState: [[Int]] = []
    var solution: [[Int]] = []
    
    private var defaultIndexes: [Bool] = []
    
}

// MARK: MEMBER
extension SudokuViewModel {
    
    func newGame() {
        self.selectedIndex = nil
        sudoku.setLevel(level: 1)
        self.defaultState = sudoku.game_sudoku
        self.solution = sudoku.original_sudoku
        print(defaultState)
        print(solution)
        self.currentState.accept(sudoku.game_sudoku)
        self.defaultIndexes = self.defaultState
            .flatMap { $0 }
            .map { $0 != 0 }
    }
    
    func isDefault(index: Int) -> Bool {
        return defaultIndexes[index]
    }
    
}

// MARK: CHECKING
extension SudokuViewModel {
    
    private func checkRows(data: [Int]) {
        
    }
    
}
