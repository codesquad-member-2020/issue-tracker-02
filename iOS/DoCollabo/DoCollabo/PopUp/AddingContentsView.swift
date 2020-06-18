//
//  AddingContentsView.swift
//  DoCollabo
//
//  Created by delma on 2020/06/16.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

class AddingContentsView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var emptyView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func add(_ view: UIView) {
        emptyView.addSubview(view)
    }
    
    private func configure() {
        Bundle.main.loadNibNamed("AddingContentsView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
