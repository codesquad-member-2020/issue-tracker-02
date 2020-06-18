//
//  PopUpViewController.swift
//  DoCollabo
//
//  Created by delma on 2020/06/16.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.5
        return view
    }()
    
    private let contentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.roundCorner(cornerRadius: 16.0)
        return view
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("초기화", for: .normal)
        button.setTitleColor(UIColor(named: "key.navy"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = UIColor(named: "key.red")
        button.setPreferredSymbolConfiguration(.init(pointSize: 20, weight: .semibold, scale: .large), forImageIn: .normal)
        return button
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
        button.tintColor = UIColor(named: "key.navy")
        button.setPreferredSymbolConfiguration(.init(pointSize: 20, weight: .semibold, scale: .large), forImageIn: .normal)
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(submitButton)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func add(_ view: UIView, handler: (UIView) -> Void) {
        contentsView.addSubview(view)
        handler(contentsView)
    }
    
    private func configure() {
        self.view.backgroundColor = .clear
        configureSubViews()
        configureLayout()
        configureBackgroundView()
    }
    
    private func configureSubViews() {
        self.view.addSubview(backgroundView)
        self.view.addSubview(contentsView)
//        self.view.addSubview(resetButton)
//        self.view.addSubview(buttonStackView)
    }
    
    private func configureLayout() {
        let layouts = [
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            contentsView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            contentsView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            contentsView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            contentsView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4),
//
//            resetButton.leadingAnchor.constraint(equalTo: contentsView.leadingAnchor, constant: 12),
//            resetButton.centerYAnchor.constraint(equalTo: buttonStackView.centerYAnchor),
//
//            buttonStackView.trailingAnchor.constraint(equalTo: contentsView.trailingAnchor, constant: -12),
//            buttonStackView.bottomAnchor.constraint(equalTo: contentsView.bottomAnchor, constant: -24)
        ]
        layouts.forEach { $0.isActive = true }
    }
    
    private func configureBackgroundView() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        backgroundView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
}
