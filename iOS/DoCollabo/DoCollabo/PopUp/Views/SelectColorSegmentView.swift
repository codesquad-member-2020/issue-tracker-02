//
//  SelectColorSegmentView.swift
//  DoCollabo
//
//  Created by delma on 2020/06/15.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class SelectColorSegmentView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var hexColorLabel: UILabel!
    @IBOutlet weak var colorPickerButton: UIButton!
    
    var delegate: ColorPickerActionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        Bundle.main.loadNibNamed("SelectColorSegmentView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        configureUI()
    }
    
    private func configureUI() {
        colorPickerButton.roundCorner(cornerRadius: 12.0)
    }
    
    @IBAction func pickRandomeColor(_ sender: UIButton) {
    }
    
    @IBAction func pressColorPickerButton(_ sender: UIButton) {
        delegate?.tappedColorPicker()
    }
}
