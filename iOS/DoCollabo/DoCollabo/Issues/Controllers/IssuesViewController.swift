//
//  IssuesViewController.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/08.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class IssuesViewController: UIViewController {

    @IBOutlet weak var titleHeaderBackgroundView: UIView!
    @IBOutlet weak var issuesCollectionView: IssuesCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fakeConfigureToken()
        configureCollectionViewDelegate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkToken()
        titleHeaderBackgroundView.roundCorner(cornerRadius: 16.0)
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
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 120)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12.0
    }
}
