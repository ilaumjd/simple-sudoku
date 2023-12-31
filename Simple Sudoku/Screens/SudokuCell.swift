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
            label.textColor = .colorWhite
            self.isUserInteractionEnabled = false
        } else {
            label.textColor = .colorOrange
            self.isUserInteractionEnabled = true
        }
    }
    
    func setNumber(number: Int) {
        if (1...9).contains(number) {
            label.text = "\(number)"
        } else {
            label.text = ""
        }
    }
    
    func setSelected(isSelected: Bool) {
        if isSelected {
            self.layer.borderWidth = 3
            self.layer.cornerRadius = 3
        } else {
            self.layer.borderWidth = 0
            self.layer.cornerRadius = 0
        }
    }

}
