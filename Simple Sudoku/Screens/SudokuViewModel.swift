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
        sudoku.setLevel(level: 1)
        self.defaultState = sudoku.game_sudoku
        self.solution = sudoku.original_sudoku
        populate()
    }
    
    func populate() {
        self.selectedIndex = nil
        self.currentState.accept(self.defaultState)
        self.defaultIndexes = self.defaultState
            .flatMap { $0 }
            .map { $0 != 0 }
    }
    
    func isDefault(index: Int) -> Bool {
        return defaultIndexes[index]
    }
    
    func dummyGame() {
        var dummy = SudokuDummies.dummy1
        dummy[0][0] = 0
        dummy[4][6] = 0
        dummy[5][1] = 0
        self.defaultState = dummy
        self.solution = SudokuDummies.dummy1
        populate()
    }
    
}

// MARK: CHECKING
extension SudokuViewModel {
    
    private func checkRows(data: [Int]) {
        
    }
    
}
