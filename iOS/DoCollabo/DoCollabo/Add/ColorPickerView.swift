//
//  ColorPickerView.swift
//  DoCollabo
//
//  Created by delma on 2020/06/15.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

class ColorPickerView: UIView {
    
    @IBOutlet var contentView: UIView!
<<<<<<< Updated upstream
    @IBOutlet weak var hexColor: UILabel!
=======
    @IBOutlet weak var hexColorLabel: UILabel!
>>>>>>> Stashed changes
    @IBOutlet weak var colorView: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        Bundle.main.loadNibNamed("ColorPickerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        configureUI()
    }
    
    private func configureUI() {
        colorView.roundCorner(cornerRadius: 12.0)
    }
    
    @IBAction func pickRandomeColor(_ sender: UIButton) {
    }
<<<<<<< Updated upstream
=======
    
    func changeHexColorLabel(_ text: String) {
        
    }
>>>>>>> Stashed changes
}
