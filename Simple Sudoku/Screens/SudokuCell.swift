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
    
    func setDefault(isDefault: Bool) {
        if isDefault {
            label.textColor = .colorOrange
        } else {
            label.textColor = .colorWhite
        }
    }
    
    func setNumber(number: Int) {
        if (1...9).contains(number) {
            label.text = "\(number)"
        } else {
            label.text = ""
        }
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
