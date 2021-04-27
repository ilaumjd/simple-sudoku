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
    private let lineWidth: CGFloat = 3
    
    @IBOutlet weak var lbSudoku: UILabel!
    @IBOutlet weak var lbTimeTitle: UILabel!
    @IBOutlet weak var lbTimeValue: UILabel!
    @IBOutlet weak var btNewGame: UIButton!
    @IBOutlet weak var btSolveMe: UIButton!
    @IBOutlet weak var cvSudoku: UICollectionView!
    @IBOutlet weak var svNumber: UIStackView!
    
    @IBOutlet weak var btDummy: UIButton!
    
    static func create() -> SudokuViewController {
        return SudokuViewController(nibName: "SudokuViewController", bundle: nil)
    }
    
}

// MARK: LIFECYCLE
extension SudokuViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRx_btNewGame()
        setupRx_btSolveMe()
        setupRx_cvSudoku()
        setupRxTimer()
        setupRxAlert()
        
        vm.newGame()
        
        setupDummy()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.layoutIfNeeded()
        drawLines()
    }
    
    private func setupDummy() {
//        btDummy.backgroundColor = .red
        btDummy.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.vm.dummyGame()
            }).disposed(by: disposeBag)
    }

}

// MARK: UI
extension SudokuViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupUI() {
        setupFonts()
        setup_cvSudoku()
        setup_svNumber()
    }
    
    private func setupFonts() {
        lbSudoku.font = .rounded(ofSize: 100, weight: .bold)
        lbTimeTitle.font = .rounded(ofSize: 14, weight: .medium)
        lbTimeValue.font = .systemFont(ofSize: 24, weight: .bold)
        btNewGame.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        btSolveMe.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private func setup_cvSudoku() {
        cvSudoku.register(UINib(nibName: SudokuCell.identifier, bundle: nil), forCellWithReuseIdentifier: SudokuCell.identifier)
        cvSudoku.layer.cornerRadius = 10
        cvSudoku.layer.borderWidth = lineWidth
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
            setupRx_btNumber(button: button)
        }
    }
    
    private func drawLines() {
        let long = cvSudoku.frame.width
        let startPos1 = (long / 3) - (lineWidth / 2)
        let startPos2 = (long * 2 / 3) - (lineWidth / 2)
        
        drawLine(x: startPos1, y: 0, width: lineWidth, height: long)
        drawLine(x: startPos2, y: 0, width: lineWidth, height: long)
        drawLine(x: 0, y: startPos1, width: long, height: lineWidth)
        drawLine(x: 0, y: startPos2, width: long, height: lineWidth)
    }
    
    private func drawLine(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(rect: CGRect(x: x, y: y, width: width, height: height)).cgPath
        layer.fillColor = UIColor.colorOrange.cgColor
        cvSudoku.layer.addSublayer(layer)
    }
    
}

// MARK: RX
extension SudokuViewController {
    
    private func setupRx_btNewGame() {
        btNewGame.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.vm.newGame()
            }).disposed(by: disposeBag)
    }
    
    private func setupRx_btSolveMe() {
        btSolveMe.rx.tap
            .subscribe(onNext: { [weak self] in
                if let vm = self?.vm {
//                    vm.currentState.accept(vm.solution)
                    vm.solve()
                }
            }).disposed(by: disposeBag)
    }
    
    private func setupRx_cvSudoku() {
        cvSudoku.rx.setDelegate(self).disposed(by: disposeBag)
        cvSudoku.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.vm.selectedIndex = indexPath.item
                self?.cvSudoku.reloadData()
            }).disposed(by: disposeBag)
        vm.currentState
            .map {
                $0.flatMap { $0 }
            }
            .bind(to: cvSudoku.rx.items(cellIdentifier: SudokuCell.identifier, cellType: SudokuCell.self)) { [weak self] index, number, cell in
                cell.backgroundColor = index % 2 == 0 ? .colorDark1 : .colorDark2
                cell.setDefault(isDefault: self?.vm.isDefault(index: index) ?? false)
                cell.setNumber(number: number)
                cell.setSelected(isSelected: (self?.vm.selectedIndex ?? -1) == index)
            }.disposed(by: disposeBag)
    }
    
    private func setupRx_btNumber(button: UIButton) {
        button.rx.tap
            .subscribe(onNext: { [weak self] in
                if let currentState = self?.vm.currentState, let selectedIndex = self?.vm.selectedIndex {
                    var temp = currentState.value
                    temp[selectedIndex/9][selectedIndex%9] = button.tag
                    currentState.accept(temp)
                }
            }).disposed(by: disposeBag)
    }
    
    private func setupRxTimer() {
        vm.timerString.bind(to: lbTimeValue.rx.text).disposed(by: disposeBag)
    }
    
    private func setupRxAlert() {
        self.vm.alert
            .subscribe(onNext: { [weak self] isSuccess in
                var title = ""
                var message = ""
                if isSuccess {
                    title = "Congratulations"
                    message = "You completed the game"
                } else {
                    title = "Failed"
                    message = "You ran out of time"
                }
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alert, animated: true)
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
