//
//  HomeViewController.swift
//  GitColab
//
//  Created by Jin younkyum on 2022/05/26.
//

import UIKit

class HomeViewController: UIViewController {
    
    var userList = ["User1", "User2"]

    @IBOutlet weak var todayCommitCount: UILabel!
    @IBOutlet weak var mainNameLabel: UILabel!
    @IBOutlet weak var userCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userCollectionView.register(UINib(nibName:"MemberCollectionViewCell" , bundle: .main), forCellWithReuseIdentifier: "MemberCollectionViewCell")
        setupFlowLayout()
        // Do any additional setup after loading the view.
    }
    
    private func setupFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumLineSpacing = 10
        
        let halfWidth = UIScreen.main.bounds.width / 2
        flowLayout.itemSize = CGSize(width: halfWidth * 1.83, height: halfWidth * 0.45)
        self.userCollectionView.collectionViewLayout = flowLayout
    }
    
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemberCollectionViewCell", for: indexPath) as? MemberCollectionViewCell else { return UICollectionViewCell() }
        
        if indexPath.row == userList.count {
            cell.plusView.alpha = 1
            cell.todayCommitLabel.alpha = 0
            cell.commitLabel.alpha = 0
            cell.nameLabel.alpha = 0
        } else {
            cell.plusView.alpha = 0
            cell.nameLabel.text = userList[indexPath.row]
        }
        
        
        return cell
    }
    
    
}
