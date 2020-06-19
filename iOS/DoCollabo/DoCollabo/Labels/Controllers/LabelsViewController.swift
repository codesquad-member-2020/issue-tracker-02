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
    private var popUpViewController: LabelPopUpViewController!
    
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
    func newButtonDidTap() {
        present(popUpViewController, animated: true, completion: nil)
    }
}

// MARK:- ButtonStackActionDelegate

extension LabelsViewController: PopUpViewControllerDelegate {
    func cancelButtonDidTap() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK:- Configuration

extension LabelsViewController {
    private func configure() {
        configureHeaderView()
        configurePopUpView()
        configureCollectionView()
        configureCollectionViewDataSource()
        configureUseCase()
    }
    
    private func configurePopUpView() {
        popUpViewController = LabelPopUpViewController()
        popUpViewController.modalPresentationStyle = .overCurrentContext
        popUpViewController.modalTransitionStyle = .crossDissolve
        popUpViewController.configureLabelPopupViewController()
        popUpViewController.popUpViewControllerDelegate = self
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
