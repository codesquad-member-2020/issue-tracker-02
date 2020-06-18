//
//  ColorPickerViewController.swift
//  DoCollabo
//
//  Created by delma on 2020/06/18.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit
import Colorful

final class ColorPickerViewController: PopUpViewController {
    
    private let palette: ColorPicker = {
         let picker = ColorPicker()
          picker.translatesAutoresizingMaskIntoConstraints = false
          picker.set(color: UIColor(displayP3Red: 1.0, green: 1.0, blue: 0, alpha: 1), colorSpace: .sRGB)
          return picker
      }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        configureSubViews()
        configureLayout()
    }
    
    private func configureSubViews() {
        view.addSubview(palette)
    }
    
    private func configureLayout() {
        let layout = [
            
            palette.centerXAnchor.constraint(equalTo: contentsView.centerXAnchor),
            palette.leadingAnchor.constraint(equalTo: contentsView.leadingAnchor, constant: 12),
            palette.trailingAnchor.constraint(equalTo: contentsView.trailingAnchor, constant: -12),
            palette.heightAnchor.constraint(equalTo: contentsView.heightAnchor, multiplier: 0.6)
        ]
        layout.forEach { $0.isActive = true }
    }
}
