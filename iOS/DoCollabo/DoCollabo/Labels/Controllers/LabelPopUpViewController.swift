//
//  LabelPopUpViewController.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/18.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

protocol LabelPopUpViewControllerDelegate: class {
    func submitButtonDidTap(label: IssueLabel, isEditMode: Bool, at indexPath: IndexPath?)
}

final class LabelPopUpViewController: PopUpViewController {
    
    private var popUpColorPickerView: PopUpColorPickerView!
    private var selectedColorHexString: String!
    private var isEditMode: Bool = false
    private var editingLabel: IssueLabel!
    private var indexPath: IndexPath?
    
    weak var labelPopUpDelegate: LabelPopUpViewControllerDelegate?
    
    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    func configureIndexPath(_ indexPath: IndexPath) {
        self.indexPath = indexPath
    }
    
    func configureEditMode(_ isEditMode: Bool) {
        self.isEditMode = isEditMode
    }
    
    func configureLabelPopupViewController() {
        configure()
        configureUI()
        configureSegmentView(popUpColorPickerView)
        popUpColorPickerView.fillSuperview()
        popUpColorPickerView.delegate = self
        configureKeyboardNotification()
    }
    
    func updatePopupViewForEditing(with label: IssueLabel) {
        self.editingLabel = label
        var hexString = label.colorHexString
        if !hexString.contains("#") {
            hexString = "#\(hexString)"
        }
        contentView.updateTextFields(title: label.title, description: label.description)
        let color = UIColor(hexString: label.colorHexString)
        popUpColorPickerView.configureColorInfo(color: color, hexString: hexString)
        selectedColorHexString = hexString
    }
    
    private func configureUI() {
        popUpColorPickerView = PopUpColorPickerView()
    }
    
    func configureRandomColor() {
        let randomColorInfo = randomColor()
        popUpColorPickerView.configureColorInfo(color: randomColorInfo.color, hexString: randomColorInfo.hexString)
        selectedColorHexString = randomColorInfo.hexString
    }
    
    private func randomColor() -> (color: UIColor, hexString: String) {
        let randomColor: UIColor = .generateRandomColor()
        let hexString = randomColor.hexString
        return (randomColor, hexString)
    }
}

// MARK:- ColorPickerActionDelegate

extension LabelPopUpViewController: ColorPickerActionDelegate {
    func colorPickerButtonDidTap() {
        let colorPickerViewController = ColorPickerViewController()
        colorPickerViewController.modalPresentationStyle = .overCurrentContext
        colorPickerViewController.configureColorPickerView(UIColor(hexString: selectedColorHexString))
        colorPickerViewController.delegate = self
        present(colorPickerViewController, animated: false, completion: nil)
    }
    
    func randomButtonDidTap() -> (color: UIColor, hexString: String) {
        let colorInfo = randomColor()
        selectedColorHexString = colorInfo.hexString
        return colorInfo
    }
}

// MARK:- ColorPickerDelegate

extension LabelPopUpViewController: ColorPickerViewControllerDelegate {
    func SubmitButtonDidTap(color: UIColor) {
        popUpColorPickerView.configureColorInfo(color: color, hexString: color.hexString)
        selectedColorHexString = color.hexString
    }
}

 // MARK: - overriding

extension LabelPopUpViewController {
    override func submitButtonDidTap() {
        guard let validContents = validContents() else { return }
        dismiss(animated: true, completion: nil)
        if isEditMode {
            editingLabel.update(
                title: validContents.title,
                colorHexString: selectedColorHexString,
                description: validContents.description)
            labelPopUpDelegate?.submitButtonDidTap(label: editingLabel, isEditMode: isEditMode, at: indexPath)
        } else {
            let newLabel = IssueLabel(
                id: nil,
                title: validContents.title,
                colorHexString: selectedColorHexString,
                description: validContents.description)
            labelPopUpDelegate?.submitButtonDidTap(label: newLabel, isEditMode: isEditMode, at: nil)
        }
    }
}

// MARK:- Keyboard Notification

extension LabelPopUpViewController {
    private func configureKeyboardNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        movePopUpContainerView(constant: -80)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        movePopUpContainerView(constant: 0)
    }
}
