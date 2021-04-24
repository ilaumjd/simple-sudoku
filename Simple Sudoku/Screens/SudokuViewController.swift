//
//  SudokuViewController.swift
//  Simple Sudoku
//
//  Created by aku pintar indonesia on 24/04/21.
//

import UIKit

class SudokuViewController: UIViewController {
    
    static func create() -> SudokuViewController {
        return SudokuViewController(nibName: "SudokuViewController", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
