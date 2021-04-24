//
//  SudokuCell.swift
//  Simple Sudoku
//
//  Created by aku pintar indonesia on 24/04/21.
//

import UIKit

class SudokuCell: UICollectionViewCell {
    
    static let identifier = "SudokuCell"
    
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        self.layer.borderColor = UIColor.colorOrange.cgColor
        self.layer.borderWidth = 0
    }
    
    func select() {
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 3
    }
    
    func deselect() {
        self.layer.borderWidth = 0
        self.layer.cornerRadius = 0
    }

}
