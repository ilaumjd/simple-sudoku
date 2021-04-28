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
    
    let alert = PublishSubject<String>()
    let timer = Observable<Int>
        .interval(.seconds(1), scheduler: MainScheduler.instance)
        .map { 5 * 60 - $0 }
        .take(until: { $0 == 0 }, behavior: .inclusive)
    var timerString = BehaviorRelay<String>(value: "")
    var timerObserver: Disposable?
    
    let currentState = BehaviorRelay<[[Int]]>(value: [])
    var defaultState: [[Int]] = []
    var solution: [[Int]] = []
    
    private var defaultIndexes: [Bool] = []
    
    init() {
        setupRxChecking()
    }
    
}

// MARK: MEMBER
extension SudokuViewModel {
    
    func newGame() {
        sudoku.setLevel(level: 1)
        self.defaultState = sudoku.game_sudoku
        self.solution = sudoku.original_sudoku
        start()
    }
    
    func dummyGame() {
        var dummy = SudokuDummies.hard
        self.solution = dummy
        dummy[0][0] = 0
        dummy[4][7] = 0
        dummy[5][1] = 0
        self.defaultState = dummy
        start()
    }
    
    private func start() {
        self.selectedIndex = nil
        self.currentState.accept(self.defaultState)
        self.defaultIndexes = self.defaultState
            .flatMap { $0 }
            .map { $0 != 0 }
        
        self.timerObserver?.dispose()
        self.timerObserver = self.timer
            .subscribe(onNext: { [weak self] seconds in
                self?.timerString.accept(Double(seconds).asString(style: .positional))
            }, onCompleted: { [weak self] in
                self?.alert.onNext("Time out")
            })
        self.timerObserver?.disposed(by: disposeBag)
    }
    
    func isDefault(index: Int) -> Bool {
        return defaultIndexes[index]
    }
    
    func solve() {
        let checker = SudokuChecker()
        if checker.isValid(grid: currentState.value) {
            let solver = SudokuSolver()
            solver.solve(grid: currentState.value) { grid in
                self.currentState.accept(grid)
                self.alert.onNext("Solved")
            } failed: {
                self.alert.onNext("Invalid")
            }
        } else {
            self.alert.onNext("Invalid")
        }
    }
    
}

// MARK: CHECKING
extension SudokuViewModel {
    
    private func setupRxChecking() {
//        currentState.subscribe(onNext: { [weak self] currentState in
//            if let solution = self?.solution, !solution.isEmpty, currentState == solution {
//                self?.timerObserver?.dispose()
//                self?.alert.onNext("")
//            }
//        }).disposed(by: disposeBag)
    }
    
}
