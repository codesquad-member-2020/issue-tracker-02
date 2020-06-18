//
//  ColorPickerView.swift
//  DoCollabo
//
//  Created by delma on 2020/06/17.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit
import Colorful

class ColorPickerView: UIView {
    @IBOutlet weak var palette: ColorPicker!
    
    var colorSpace: HRColorSpace = .sRGB

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureColorPicker()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureColorPicker()
    }
    
    private func configureColorPicker() {
        palette.set(color: UIColor(displayP3Red: 1.0, green: 1.0, blue: 0, alpha: 1), colorSpace: colorSpace)
    }
}
