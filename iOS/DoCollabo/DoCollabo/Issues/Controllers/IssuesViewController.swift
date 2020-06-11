//
//  IssuesViewController.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/08.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit
import Alamofire

final class IssuesViewController: UIViewController {

    @IBOutlet weak var titleHeaderBackgroundView: UIView!
    @IBOutlet weak var titleHeaderView: TitleHeaderView! {
        didSet {
            titleHeaderView.configureTitle("이슈")
        }
    }
    @IBOutlet weak var issuesCollectionView: IssuesCollectionView!
    
    private var issuesUseCase: UseCase!
    private var dataSource: IssuesCollectionViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fakeConfigureToken()
        configureCollectionViewDelegate()
        configureCollectionViewDataSource()
        configureUseCase()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkToken()
        titleHeaderBackgroundView.roundCorner(cornerRadius: 16.0)
    }
    
    private func configureCollectionViewDataSource() {
        dataSource = IssuesCollectionViewDataSource(changedHandler: { (_) in
            self.issuesCollectionView.reloadData()
        })
        issuesCollectionView.dataSource = dataSource
    }
    
    private func configureUseCase() {
        issuesUseCase = UseCase(networkDispatcher: AF)
    }
    
    private func fakeConfigureToken() {
        UserDefaults.standard.removeObject(forKey: .jwtToken)
    }
    
    private func checkToken() {
        guard let token = UserDefaults.standard.object(forKey: .jwtToken) as? String
        else {
            presentSignIn()
            return
        }
        fetchIssues()
    }
    
    private func presentSignIn() {
        guard let singInViewController = storyboard?.instantiateViewController(
            identifier: String(describing: SignInViewController.self))
        else {
            return
        }
        singInViewController.modalPresentationStyle = .fullScreen
        present(singInViewController, animated: true, completion: nil)
    }
    
    private func fetchIssues() {
        let request = FetchIssuesRequest().asURLRequest()
        issuesUseCase.getResources(request: request, dataType: [Issue].self) { (result) in
            switch result {
            case .success(let issues):
                self.dataSource.updateIssues(issues)
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
            self.fetchIssues()
        }
        alertController.configure(actionTitle: "확인") { (_) in
            return
        }
        self.present(alertController, animated: true)
    }
}

extension String {
    static let jwtToken: String = "jwtToken"
}

// MARK:- UICollectionViewDelegateFlowLayout

extension IssuesViewController: UICollectionViewDelegateFlowLayout {
    private func configureCollectionViewDelegate() {
        issuesCollectionView.delegate = self
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12.0
    }
}
