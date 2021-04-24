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
    
    let sudokuRelay = BehaviorRelay<[Int]>(value: [])
    
    var selectedIndex: Int?
    
    var defaultState: [[Int]] = []
    var solution: [[Int]] = []
    
    init() {
//        sudokuRelay = BehaviorRelay(value: sudokuRaw)
    }
    
    func newGame() {
        sudoku.setLevel(level: 1)
        self.defaultState = sudoku.game_sudoku
        self.solution = sudoku.original_sudoku
        
        self.sudokuRelay.accept(self.defaultState.flatMap{$0})
    }
    
    func setupRxSudoku() {
        sudokuRelay.subscribe(onNext: { sudokuData in
            
        }).disposed(by: disposeBag)
    }
    
}

// MARK: CHECKING
extension SudokuViewModel {
    
    private func checkRows(data: [Int]) {
        
    }
    
}
