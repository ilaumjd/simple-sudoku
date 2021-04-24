//
//  SudokuViewController.swift
//  Simple Sudoku
//
//  Created by aku pintar indonesia on 24/04/21.
//

import UIKit
import RxSwift
import RxCocoa

class SudokuViewController: UIViewController {
    
    private let vm = SudokuViewModel()
    private let disposeBag = DisposeBag()
    private let lineSize: CGFloat = 3
    
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
        
        setupRxCvSudoku()
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
        btNewGame.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.vm.newGame()
            }).disposed(by: disposeBag)
    }
    
    private func setup_btSolveMe() {
        btSolveMe.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private func setup_cvSudoku() {
        cvSudoku.register(UINib(nibName: SudokuCell.identifier, bundle: nil), forCellWithReuseIdentifier: SudokuCell.identifier)
        cvSudoku.layer.cornerRadius = 10
        cvSudoku.layer.borderWidth = lineSize
        cvSudoku.layer.borderColor = UIColor.orange.cgColor
    }
    
    private func setup_svNumber() {
        svNumber.axis = .horizontal
        svNumber.distribution = .fillEqually
        svNumber.alignment = .fill
        
        for i in 1...9 {
            let button = UIButton()
            button.tag = i
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.setTitle("\(i)", for: .normal)
            button.setTitleColor(.colorDark1, for: .normal)
            button.setTitleColor(UIColor.colorDark1.withAlphaComponent(0.5), for: .highlighted)
            button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)

            svNumber.addArrangedSubview(button)
            setupRxBtNumber(button: button)
        }
    }
    
}

// MARK: MEMBER
extension SudokuViewController {
    
    private func setupRxCvSudoku() {
        cvSudoku.rx.setDelegate(self).disposed(by: disposeBag)
        cvSudoku.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.vm.selectedIndex = indexPath.item
                if let cell = self?.cvSudoku.cellForItem(at: indexPath) as? SudokuCell {
                    cell.select()
                }
            }).disposed(by: disposeBag)
        cvSudoku.rx.itemDeselected
            .subscribe(onNext: { [weak self] indexPath in
                if let cell = self?.cvSudoku.cellForItem(at: indexPath) as? SudokuCell {
                    cell.deselect()
                }
            }).disposed(by: disposeBag)
        vm.sudokuRelay
            .bind(to: cvSudoku.rx.items(cellIdentifier: SudokuCell.identifier, cellType: SudokuCell.self)) { index, number, cell in
                cell.backgroundColor = index % 2 == 0 ? .colorDark1 : .colorDark2
                cell.setNumber(number: number)
            }.disposed(by: disposeBag)
    }
    
    private func setupRxBtNumber(button: UIButton) {
        button.rx.tap
            .subscribe(onNext: { [weak self] in
                let indexPath = IndexPath(item: self?.vm.selectedIndex ?? 0, section: 0)
                if let cell = self?.cvSudoku.cellForItem(at: indexPath) as? SudokuCell {
                    cell.setNumber(number: button.tag)
                }
            }).disposed(by: disposeBag)
    }
    
}

// MARK: COLLECTION VIEW
extension SudokuViewController: UICollectionViewDelegateFlowLayout {
    
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
    
}
