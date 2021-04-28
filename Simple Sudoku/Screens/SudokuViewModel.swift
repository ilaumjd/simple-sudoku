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
    private let checker = SudokuChecker()
    private let solver = SudokuSolver()
    
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
        var dummy = SudokuDummies.dummy
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
        if checker.isValid(grid: currentState.value) {
            solver.solve(grid: currentState.value) { grid in
                self.currentState.accept(grid)
            } failed: {
                self.alert.onNext("Invalid")
                self.timerObserver?.dispose()
            }
        } else {
            self.alert.onNext("Invalid")
            self.timerObserver?.dispose()
        }
    }
    
}

// MARK: CHECKING
extension SudokuViewModel {
    
    private func setupRxChecking() {
        currentState.subscribe(onNext: { [weak self] currentState in
            if currentState.isEmpty {
                return
            }
            if self?.checker.isSolved(grid: currentState) ?? false {
                self?.alert.onNext("Solved")
                self?.timerObserver?.dispose()
            }
        }).disposed(by: disposeBag)
    }
    
}
