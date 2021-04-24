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
    
    var selectedIndex: Int?
    
    var sudokuRaw = [ [0,0,0,0,0,0,0,0,0],
                      [0,0,0,0,0,0,0,0,0],
                      [0,0,0,0,0,0,0,0,0],
                      [0,0,0,0,0,0,0,0,0],
                      [0,0,0,0,0,0,1,0,0],
                      [0,0,0,0,0,0,0,0,0],
                      [0,0,0,0,0,0,9,0,0],
                      [0,0,0,0,0,0,0,0,0],
                      [0,0,0,0,0,0,0,0,0] ]
    
    
    let sudoku: BehaviorRelay<[Int]>
    
    init() {
//        sudoku = BehaviorRelay(value: Array(sudokuRaw.joined()))
        sudoku = BehaviorRelay(value: SudokuExamples.example1)
    }
}
