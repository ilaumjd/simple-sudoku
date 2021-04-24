//
//  SudokuViewModel.swift
//  Simple Sudoku
//
//  Created by aku pintar indonesia on 24/04/21.
//

import Foundation
import RxSwift
import RxCocoa

class SudokuViewModel {
    
    private let disposeBag = DisposeBag()
    
    var selectedIndex: Int?
    let sudokuData: BehaviorRelay<[Int]>
    
    init() {
        var sudokuRaw = SudokuExamples.example1
        sudokuRaw[0] = 0
        sudokuData = BehaviorRelay(value: sudokuRaw)
    }
    
    func setupRxSudoku() {
        sudokuData.subscribe(onNext: { sudokuData in
            
        }).disposed(by: disposeBag)
    }
    
}

// MARK: CHECKING
extension SudokuViewModel {
    
    private func checkRows(data: [Int]) {
        
    }
    
}
