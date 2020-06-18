//
//  LabelPopUpViewController.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/18.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class LabelPopUpViewController: PopUpViewController {
    
    func configureLabelPopupViewController() {
        let popUpContentView = PopUpContentView()
        let popUpColorPickerView = PopUpColorPickerView()
        popUpContentView.configurePlaceholderView(popUpColorPickerView)
        popUpColorPickerView.fillSuperview()
        popUpColorPickerView.delegate = self
        configureContentView(popUpContentView)
        let popUpFooterView = PopUpFooterView()
        configureFooterView(popUpFooterView)
    }
}

extension LabelPopUpViewController: ColorPickerActionDelegate {
    func colorPickerButtonDidTap() {
        
    }
}
