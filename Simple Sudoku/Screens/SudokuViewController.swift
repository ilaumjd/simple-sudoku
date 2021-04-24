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
    
    let lineSize: CGFloat = 4
    
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
        lbTimeTitle.font = .rounded(ofSize: 14, weight: .medium)
    }
    
    private func setup_lbTimeValue() {
        lbTimeValue.font = .systemFont(ofSize: 24, weight: .bold)
    }
    
    private func setup_btNewGame() {
        btNewGame.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private func setup_btSolveMe() {
        btSolveMe.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private func setup_cvSudoku() {
        cvSudoku.register(UINib(nibName: SudokuCell.identifier, bundle: nil), forCellWithReuseIdentifier: SudokuCell.identifier)
        cvSudoku.delegate = self
        cvSudoku.dataSource = self
        cvSudoku.layer.cornerRadius = 10
        cvSudoku.layer.borderWidth = lineSize
        cvSudoku.layer.borderColor = UIColor.orange.cgColor
    }
    
    private func setup_svNumber() {
        
    }
    
}

// MARK: COLLECTION VIEW
extension SudokuViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9 * 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SudokuCell.identifier, for: indexPath)
        if indexPath.item % 2 == 0 {
            cell.backgroundColor = .colorDark1
        } else {
            cell.backgroundColor = .colorDark2
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 9
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
}
