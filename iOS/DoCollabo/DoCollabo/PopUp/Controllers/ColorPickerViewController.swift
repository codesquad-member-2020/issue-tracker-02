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
    
    private var palette: ColorPicker!
    
    func configurePalette() {
        let randomRange = CGFloat.random(in: 0...1.0)
        configure()
        palette = ColorPicker()
        palette.backgroundColor = .white
        palette.translatesAutoresizingMaskIntoConstraints = false
        palette.set(
            color: UIColor(displayP3Red: randomRange, green: randomRange, blue: randomRange, alpha: 1),
            colorSpace: .sRGB)
        configureContentView(palette)
        configureSecondLevelBackgroundView()
    }
}

extension ColorPickerViewController {
    override func cancelButtonDidTap() {
        dismiss(animated: false, completion: nil)
    }
}
