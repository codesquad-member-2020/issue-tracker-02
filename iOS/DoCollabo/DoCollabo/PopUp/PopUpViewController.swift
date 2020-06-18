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
    
    let contentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.roundCorner(cornerRadius: 16.0)
        return view
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
    }
    
    private func configureSubViews() {
        view.addSubview(backgroundView)
        view.addSubview(contentsView)
    }
    
    private func configureLayout() {
        let layouts = [
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            contentsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35)
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
