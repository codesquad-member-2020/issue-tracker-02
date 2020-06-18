//
//  LabelPopUpViewController.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/18.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class LabelPopUpViewController: PopUpViewController {
    
    private var popUpContentView: PopUpContentView!
    private var popUpColorPickerView: PopUpColorPickerView!
    
    func configureLabelPopupViewController() {
        configure()
        configureUI()
        popUpContentView.configurePlaceholderView(popUpColorPickerView)
        popUpColorPickerView.fillSuperview()
        popUpColorPickerView.delegate = self
        configureContentView(popUpContentView)
    }
    
    private func configureUI() {
        popUpContentView = PopUpContentView()
        popUpColorPickerView = PopUpColorPickerView()
    }
}

extension LabelPopUpViewController: ColorPickerActionDelegate {
    func colorPickerButtonDidTap() {
        
    }
}
