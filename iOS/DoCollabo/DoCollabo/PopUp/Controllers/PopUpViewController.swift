//
//  PopUpViewController.swift
//  DoCollabo
//
//  Created by delma on 2020/06/16.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

protocol PopUpViewControllerDelegate: class {
    func cancelButtonDidTap()
}

class PopUpViewController: UIViewController {
    
    private var backgroundView: UIView!
    private var popUpContainerView: UIView!
    internal var contentView: PopUpContentView!
    private var footerView: PopUpFooterView!
    
    private var popUpContainerCenterY: NSLayoutConstraint!
    
    weak var popUpViewControllerDelegate: PopUpViewControllerDelegate?
    
    func resetContentView() {
        contentView.reset()
    }
    
    func configureContentView(_ otherView: UIView) {
        contentView.addSubview(otherView)
        otherView.fillSuperview()
    }
    
    func configureSecondLevelBackgroundView() {
        backgroundView.alpha = 0
    }
    
    func configureSegmentView(_ view: UIView) {
        contentView.configurePlaceholderView(view)
    }
    
    func validContents() -> (title: String, description: String?)? {
        let newFeature = contentView.submit()
        guard newFeature.title != "", let title = newFeature.title else {
            presentTitleEmptyAlert()
            return nil
        }
        guard title.count < 11 else {
            presentOverTitleAlert()
            return nil
        }
        guard let description = newFeature.description, description.count < 21 else {
            presentOverContentsAlert()
            return nil
        }
        return (title, newFeature.description)
    }
}

// MARK:- Keyboard Notificaiton

extension PopUpViewController {
    func movePopUpContainerView(constant: CGFloat) {
        popUpContainerCenterY.constant = constant
        UIView.animateCurveEaseOut(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
}

// MARK:- PopUpFooterViewAction

@objc extension PopUpViewController: PopUpFooterViewActionDelegate {
    func cancelButtonDidTap() {
        popUpViewControllerDelegate?.cancelButtonDidTap()
    }
    
    func resetButtonDidTap() {
        contentView.reset()
    }
    
    func submitButtonDidTap() {
        
    }
}

// MARK:- Configuration

extension PopUpViewController {
    func configure() {
        self.view.backgroundColor = .clear
        configureUI()
        configureFooterView()
        configureSubViews()
        configureLayout()
        configureTapGestureRecognizer()
    }
    
    private func configureUI() {
        contentView = PopUpContentView()
        footerView = PopUpFooterView()
        backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0.5
        popUpContainerView = UIView()
        popUpContainerView.backgroundColor = .tertiarySystemBackground
        popUpContainerView.roundCorner(cornerRadius: 16.0)
    }
    
    private func configureFooterView() {
        footerView.delegate = self
    }
    
    private func configureSubViews() {
        view.addSubview(backgroundView)
        view.addSubview(popUpContainerView)
        popUpContainerView.addSubview(contentView)
        popUpContainerView.addSubview(footerView)
    }
    
    private func configureLayout() {
        backgroundView.fillSuperview()
//        frameView.centerInSuperview()
        popUpContainerView.translatesAutoresizingMaskIntoConstraints = false
        popUpContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popUpContainerCenterY = NSLayoutConstraint(
            item: popUpContainerView!,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0)
        popUpContainerCenterY.isActive = true
        let sidePadding: CGFloat = 24.0
        popUpContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        popUpContainerView.heightAnchor.constraint(equalTo: popUpContainerView.widthAnchor, multiplier: 1.1).isActive = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.topAnchor.constraint(equalTo: popUpContainerView.topAnchor, constant: 24).isActive = true
        contentView.leadingAnchor.constraint(equalTo: popUpContainerView.leadingAnchor, constant: sidePadding).isActive = true
        contentView.trailingAnchor.constraint(equalTo: popUpContainerView.trailingAnchor, constant: -sidePadding).isActive = true
        contentView.bottomAnchor.constraint(equalTo: footerView.topAnchor, constant: -24).isActive = true
        
        footerView.heightAnchor.constraint(equalTo: popUpContainerView.heightAnchor, multiplier: 0.2).isActive = true
        footerView.bottomAnchor.constraint(equalTo: popUpContainerView.bottomAnchor, constant: -24).isActive = true
        footerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        footerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    private func configureTapGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        backgroundView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    func hideSupplementaryButtons() {
        footerView.hideSupplementaryButtons()
    }
}

// MARK:- Show Alert

extension PopUpViewController {
    internal func presentTitleEmptyAlert() {
        let alert = UIAlertController(title: "알림", message: "제목을 반드시 작성해주세요.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in }
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    internal func presentOverTitleAlert() {
        let alert = UIAlertController(title: "알림", message: "제목은 10자 이하로 작성해주세요.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in }
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    internal func presentOverContentsAlert() {
        let alert = UIAlertController(title: "알림", message: "내용은 20자 이하로 작성해주세요.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in }
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
