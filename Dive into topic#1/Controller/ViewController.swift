//
//  ViewController.swift
//  Dive into topic#1
//
//  Created by Eric chung on 2022/3/28.
//

import UIKit

class ViewController: UIViewController, SelectionViewDataSource {
    
    var selectionView1 = SelectionView(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 50))
    var view1 = UIView(frame: CGRect(x: 0, y: 102, width: UIScreen.main.bounds.width, height: 80))
    var selectionView2 = SelectionView(frame: CGRect(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 50))
    var view2 = UIView(frame: CGRect(x: 0, y: 252, width: UIScreen.main.bounds.width, height: 80))
    var couldBeSelected = true
    
    var color: [UIColor] = [.red, .yellow, .blue]
    
    
    // Config SelectionView
    func textOfButtons(_ selectionView: SelectionView?, _ button: UIButton) -> String {
        if selectionView == selectionView1 {
            
            if button.tag == 0 {
                return "red"
            } else {
                return "yellow"
            }
            
        } else {
            if button.tag == 0 {
                return "red"
            } else if button.tag == 1 {
                return "yellow"
            } else {
                return "blue"
            }
        }
    }
    
    func numberOfButtons(_ selectionView: SelectionView?) -> Int {
        if selectionView == selectionView1 {
            return 2
        } else {
            return 3
        }
    }
    
    func colorOfBottomLine(_ selectionView: SelectionView?) -> UIColor {
        .white
    }
    
    func colorOfText(_ selectionView: SelectionView?, _ button: UIButton) -> UIColor {
        .white
    }
    
    func fontOfText(_ selectionView: SelectionView?, _ button: UIButton) -> String {
        return "systemFont"
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        // selectionView 1
        selectionView1.datasSource = self
        selectionView1.delegate = self
        selectionView1.backgroundColor = .clear
        selectionView1.initButton()
        selectionView1.initBottomLine()
        self.view.addSubview(selectionView1)
        
        // selectionView 2
        selectionView2.datasSource = self
        selectionView2.delegate = self
        selectionView2.backgroundColor = .clear
        selectionView2.initButton()
        selectionView2.initBottomLine()
        self.view.addSubview(selectionView2)
        
        // view1
        view1.backgroundColor = .red
        self.view.addSubview(view1)
        
        // view2
        view2.backgroundColor = .red
        self.view.addSubview(view2)
    }
}

extension ViewController: SelectionViewDelegate {
    func didSelectedButton(_ selectionView: SelectionView, at index: Int) {
        if selectionView == selectionView1 {
            view1.backgroundColor = color[index]
            if index == 1 {
            couldBeSelected = false
            } else {
            couldBeSelected = true
            }
        } else {
            view2.backgroundColor = color[index]
        }
    }
    
    func shouldSelectedButton(_ selectionView: SelectionView, at index: Int) -> Bool {
        if couldBeSelected  == false && selectionView == selectionView2 {
            return false
        } else {
            return true
        }
    }
}

