//
//  LabelPopUpViewController.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/18.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class LabelPopUpViewController: PopUpViewController {
    
    private var popUpColorPickerView: PopUpColorPickerView!
    private var selectedColor: String!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureRandomColor()
    }
    
    func configureLabelPopupViewController() {
        configure()
        configureUI()
        configureSegmentView(popUpColorPickerView)
        popUpColorPickerView.fillSuperview()
        popUpColorPickerView.delegate = self
    }
    
    private func configureUI() {
        popUpColorPickerView = PopUpColorPickerView()
        configureRandomColor()
    }
    
    private func configureRandomColor() {
        let randomColorInfo = randomColor()
        popUpColorPickerView.configureColorInfo(color: randomColorInfo.color, hexString: randomColorInfo.hexString)
        selectedColor = randomColorInfo.hexString
    }
    
    private func randomColor() -> (color: UIColor, hexString: String) {
        let randomColor = UIColor().random()
        let hexString = randomColor.hexString
        return (randomColor, hexString)
    }
}

// MARK:- ColorPickerActionDelegate

extension LabelPopUpViewController: ColorPickerActionDelegate {
    func colorPickerButtonDidTap() {
        let colorPickerViewController = ColorPickerViewController()
        colorPickerViewController.modalPresentationStyle = .overCurrentContext
        colorPickerViewController.configureColorPickerView()
        colorPickerViewController.delegate = self
        present(colorPickerViewController, animated: false, completion: nil)
    }
    
    func randomButtonDidTap() -> (color: UIColor, hexString: String) {
        let colorInfo = randomColor()
        selectedColor = colorInfo.hexString
        return colorInfo
    }
}

// MARK:- ColorPickerDelegate

extension LabelPopUpViewController: ColorPickDelegate {
    func pass(colorInfo: (color: UIColor, hexString: String)) {
        popUpColorPickerView.configureColorInfo(color: colorInfo.color, hexString: colorInfo.hexString)
        selectedColor = colorInfo.hexString
    }
}

 // MARK: - overriding

extension LabelPopUpViewController {
    override func submitButtonDidTap() {
        let newFeature = contentView.submit()
        guard newFeature.title != "", let title = newFeature.title else {
            presentTitleEmptyAlert()
            return
        }
        popUpViewControllerDelegate?.submitButtonDidTap(title: title, description: newFeature.description, additionalData: selectedColor)
    }
}
