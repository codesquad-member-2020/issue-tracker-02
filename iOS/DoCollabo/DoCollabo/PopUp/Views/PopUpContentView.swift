//
//  AddingContentsView.swift
//  DoCollabo
//
//  Created by delma on 2020/06/16.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class PopUpContentView: UIView {
    
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var placeholderView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func add(_ view: UIView) {
        placeholderView.addSubview(view)
    }
    
    private func configure() {
        Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)
        addSubview(frameView)
        frameView.frame = self.bounds
        frameView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
