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
    
}

// MARK: MEMBER
extension SudokuViewModel {
    
    func newGame() {
        sudoku.setLevel(level: 1)
        self.defaultState = sudoku.game_sudoku
        self.solution = sudoku.original_sudoku
        print(defaultState)
        print(solution)
        self.currentState.accept(sudoku.game_sudoku)
    }
    
    func getDefaultIndexes() {
//        let defaults = self.defaultState.flatMap($0)
//        BehaviorRelay<[[Int]]>(value: defaultState)
//            .map { defaultState in
//                defaultState.flatMap { $0 }
//            }
    }
    
}

// MARK: CHECKING
extension SudokuViewModel {
    
    private func checkRows(data: [Int]) {
        
    }
    
}
