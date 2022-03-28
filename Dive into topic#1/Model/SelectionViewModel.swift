//
//  SelectionViewModel.swift
//  Dive into topic#1
//
//  Created by Eric chung on 2022/3/28.
//

import Foundation
import UIKit

// MARK: SelectionView DataSource
protocol SelectionViewDataSource: AnyObject {
    func numberOfButtons (_ selectionView: SelectionView?) -> Int
    func textOfButtons (_ selectionView: SelectionView?, _ button: UIButton) -> String
    func colorOfBottomLine (_ selectionView: SelectionView?) -> UIColor
    func colorOfText (_ selectionView: SelectionView?, _ button: UIButton) -> UIColor
    func fontOfText (_ selectionView: SelectionView?, _ button: UIButton) -> String
}

// MARK: SelectionView Delegate
@objc protocol SelectionViewDelegate: AnyObject {
    @objc optional func didSelectedButton(_ selectionView: SelectionView, at index: Int)
    
    @objc optional func shouldSelectedButton(_ selectionView: SelectionView, at index: Int) -> Bool
}

// MARK: Class of selectin view
class SelectionView: UIView {
    
    weak var datasSource: SelectionViewDataSource?
    weak var delegate: SelectionViewDelegate?
    
    // Button Attributes
    var button = UIButton()
    
    
    // Caculate position
    var xValue = 0.0
    var yValue = 0.0
    
    // SelectionView Attributes
    var number = Int()
    var text = String()
    var colorOfBottomLine = UIColor()
    var colorOfText = UIColor()
    var fontOfText = String()
    
    // Bottom Line Attrbutes
    var bottomLine = UIView()
    
    func initButton () {
        number = self.datasSource?.numberOfButtons(self) ?? 2
        let width = UIScreen.main.bounds.width / CGFloat(number)
        for i in 0..<number {
            button = UIButton(frame: CGRect(x: xValue, y: yValue, width: Double(width) , height: 50.0))
            button.backgroundColor = .clear
            button.tag = i
            text = self.datasSource?.textOfButtons(self, button) ?? ""
            colorOfText = self.datasSource?.colorOfText(self, button) ?? .white
            fontOfText = self.datasSource?.fontOfText(self, button) ?? "systemFont"
            button.setTitle("\(text)", for: .normal)
            button.setTitleColor(colorOfText, for: .normal)
            button.titleLabel?.font = UIFont(name:fontOfText, size: 18)
            button.addTarget(self, action: #selector(canSelectButton), for: .touchUpInside)
            self.addSubview(button)
            xValue = xValue + Double(width)
        }
    }
    
    func initBottomLine () {
        bottomLine = UIView(frame: CGRect(x: 30, y: 50, width: button.frame.width - 60 , height: 2))
        colorOfBottomLine = self.datasSource?.colorOfBottomLine(self) ?? .blue
        bottomLine.backgroundColor = colorOfBottomLine
        self.addSubview(bottomLine)
    }
    
    @objc func canSelectButton(_ button: UIButton) {
        if self.delegate?.shouldSelectedButton?(self, at: button.tag) == true {
            self.delegate?.didSelectedButton!(self, at: button.tag)
            let xPosition = button.frame.minX + 30
            UIView.animate(withDuration: 0.25) {
                self.bottomLine.frame = CGRect(x:xPosition, y: 50, width: button.frame.width  - 60, height: 2)
            }
        } else {
            return
        }
    }
}

