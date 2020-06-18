//
//  LabelsViewController.swift
//  DoCollabo
//
//  Created by delma on 2020/06/12.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit
import Alamofire

final class LabelsViewController: UIViewController {

    @IBOutlet weak var titleHeaderBackgroundView: UIView!
    @IBOutlet weak var titleHeaderView: TitleHeaderView!
    @IBOutlet weak var labelsCollectionView: LabelsCollectionView!
    
    private var labelsUseCase: UseCase!
    private var dataSource: LabelsCollectionViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        fetchLabels()
    }
    
    private func fetchLabels() {
        let request = FetchLabelsRequest().asURLRequest()
        labelsUseCase.getResources(request: request, dataType: [IssueLabel].self) { result in
            switch result {
            case .success(let labels):
                self.dataSource.updateLabels(labels)
            case .failure(let error):
                self.presentErrorAlert(error: error)
            }
        }
    }
    
    private func presentErrorAlert(error: Error) {
        let alertController = ErrorAlertController(
            title: nil,
            message: error.localizedDescription,
            preferredStyle: .alert)
        alertController.configure(actionTitle: "재요청") { (_) in
            self.fetchLabels()
        }
        alertController.configure(actionTitle: "확인") { (_) in
            return
        }
        self.present(alertController, animated: true)
    }
}

// MARK:- HeaderViewActionDelegate

extension LabelsViewController: HeaderViewActionDelegate {
    func tappedAddView() {
        let popUpViewController = PopUpViewController()
        popUpViewController.modalPresentationStyle = .overCurrentContext
        popUpViewController.modalTransitionStyle = .crossDissolve
        configureAddingContentsView(at: popUpViewController)
        present(popUpViewController, animated: true, completion: nil)
    }
    
    private func configureAddingContentsView(at popUpViewController: PopUpViewController) {
        let addingContentsView = AddingContentsView()
        configureColorPickerView(at: addingContentsView)
        
        popUpViewController.add(addingContentsView) { superView in
            addingContentsView.translatesAutoresizingMaskIntoConstraints = false
            addingContentsView.topAnchor.constraint(equalTo: superView.topAnchor, constant: 24).isActive = true
            addingContentsView.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
            addingContentsView.widthAnchor.constraint(equalTo: superView.widthAnchor, multiplier: 0.8).isActive = true
            addingContentsView.heightAnchor.constraint(equalTo: superView.heightAnchor, multiplier: 0.5).isActive = true
        
        }
        let buttonStackView = ButtonStackView()
        popUpViewController.add(buttonStackView) { superView in
            buttonStackView.translatesAutoresizingMaskIntoConstraints = false
           buttonStackView.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
           buttonStackView.widthAnchor.constraint(equalTo: superView.widthAnchor, multiplier: 0.8).isActive = true
            buttonStackView.heightAnchor.constraint(equalTo: superView.heightAnchor, multiplier: 0.15).isActive = true
            buttonStackView.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -24).isActive = true
        }
        buttonStackView.delegate = self
    }
    
    private func configureColorPickerView(at addingContentsView: AddingContentsView) {
        let selectColorSegmentView = SelectColorSegmentView()
        addingContentsView.add(selectColorSegmentView)
        selectColorSegmentView.fillSuperview()
        selectColorSegmentView.delegate = self
    }
}

// MARK:- ButtonStackActionDelegate

extension LabelsViewController: ButtonStackActionDelegate {
    func close() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK:- ColorPickerActionDelegate

extension LabelsViewController: ColorPickerActionDelegate {
    func tappedColorPicker() {
        let colorPickerViewController = ColorPickerViewController()
        colorPickerViewController.modalPresentationStyle = .overCurrentContext
        colorPickerViewController.modalTransitionStyle = .crossDissolve
        
        present(colorPickerViewController, animated: true, completion: nil)
    }
}

// MARK:- Configuration

extension LabelsViewController {
    private func configure() {
        configureHeaderView()
        configureCollectionView()
        configureCollectionViewDataSource()
        configureUseCase()
    }
    
    private func configureHeaderView() {
        titleHeaderBackgroundView.roundCorner(cornerRadius: 16.0)
        titleHeaderView.configureTitle("레이블")
        titleHeaderView.delegate = self
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(
            width: labelsCollectionView.frame.width * 0.9,
            height: self.view.frame.height / 8)
        layout.scrollDirection = .vertical
        labelsCollectionView.collectionViewLayout = layout
        labelsCollectionView.showsVerticalScrollIndicator = false
    }
    
    private func configureCollectionViewDataSource() {
        dataSource = LabelsCollectionViewDataSource( changedHandler: { (_) in
            self.labelsCollectionView.reloadData()
        })
        labelsCollectionView.dataSource = dataSource
    }
    
    private func configureUseCase() {
        labelsUseCase = UseCase(networkDispatcher: AF)
    }
}
