//
//  SudokuViewController.swift
//  Simple Sudoku
//
//  Created by aku pintar indonesia on 24/04/21.
//

import UIKit

class SudokuViewController: UIViewController {
    
    @IBOutlet weak var lbSudoku: UILabel!
    @IBOutlet weak var lbTimeTitle: UILabel!
    @IBOutlet weak var lbTimeValue: UILabel!
    @IBOutlet weak var btNewGame: UIButton!
    @IBOutlet weak var btSolveMe: UIButton!
    @IBOutlet weak var cvSudoku: UICollectionView!
    @IBOutlet weak var svNumber: UIStackView!
    
    static func create() -> SudokuViewController {
        return SudokuViewController(nibName: "SudokuViewController", bundle: nil)
    }
    
}

// MARK: LIFECYCLE
extension SudokuViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

// MARK: UI
extension SudokuViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupUI() {
        setup_lbSudoku()
        setup_lbTimeTitle()
        setup_lbTimeValue()
        setup_btNewGame()
        setup_btSolveMe()
        setup_cvSudoku()
        setup_svNumber()
    }
    
    private func setup_lbSudoku() {
        lbSudoku.font = .rounded(ofSize: 100, weight: .bold)
    }
    
    private func setup_lbTimeTitle() {
        lbTimeTitle.font = .systemFont(ofSize: 16)
    }
    
    private func setup_lbTimeValue() {
        lbTimeValue.font = .boldSystemFont(ofSize: 24)
    }
    
    private func setup_btNewGame() {
        btNewGame.titleLabel?.font = .boldSystemFont(ofSize: 20)
    }
    
    private func setup_btSolveMe() {
        btSolveMe.titleLabel?.font = .boldSystemFont(ofSize: 20)
    }
    
    private func setup_cvSudoku() {
        
    }
    
    private func setup_svNumber() {
        
    }
    
}
