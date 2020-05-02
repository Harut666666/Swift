//
//  ViewController.swift
//  CoreGraphicsDrawView
//
//  Created by Harut on 4/26/20.
//  Copyright © 2020 Harut Yeremyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    let canves = Canvas()
    
    let undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Undo", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleUndo(){
        canves.undo()
    }
    
     let clearButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Clear", for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 14)
            button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
            return button
        }()
    
    @objc func handleClear(){
        canves.clear()
    }
    
    let yellowButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChanged), for: .touchUpInside)
        return button
    }()
    
    let redButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChanged), for: .touchUpInside)

        return button
    }()
    
    let blueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChanged), for: .touchUpInside)
 
        return button
    }()
    
    let slider:UISlider = {
       let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.addTarget(self, action: #selector(handleSliderChanged), for: .valueChanged)
        return slider
    }()
     
    @objc fileprivate func handleColorChanged(button:UIButton){
        canves.setStrokeColor(color: button.backgroundColor ?? .black)
    }
    
    @objc fileprivate func handleSliderChanged(slider: UISlider){
        canves.setStrokeWidth(width: slider.value)
    }
    
    override func loadView(){
        self.view = canves
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        canves.backgroundColor = .white
        setupLayout()
        
    }

    fileprivate func setupLayout() {
        let colorsSteckView = UIStackView(arrangedSubviews: [yellowButton,
        redButton,
        blueButton])
        colorsSteckView.distribution = .fillEqually
        
           let steckView = UIStackView(arrangedSubviews: [
               undoButton,
               clearButton,
               colorsSteckView,
               slider
           ])
        steckView.spacing = 12
        
           steckView.distribution = .fillEqually
           view.addSubview(steckView)
           
           steckView.translatesAutoresizingMaskIntoConstraints = false
           steckView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
           steckView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
           steckView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
       }
}

