//
//  EncryptoViewController.swift
//  Cripto Collection
//
//  Created by Jin younkyum on 2022/04/18.
//

import UIKit

class EncryptoViewController: UIViewController {
    var codeOption = ["Anagram", "Caesar", "Affine", "Hash(sha256)"]
    var codeOptionImage = [UIImage(systemName: "tornado"), UIImage(systemName: "a"), UIImage(systemName: "abc"), UIImage(systemName: "shadow")]
    
    
    @IBOutlet weak var encryptoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.encryptoCollectionView.register(UINib(nibName: "EncryptoCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "EncryptoCollectionViewCell")
        setupFlowLayout()
    }
    
    private func setupFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        
        let halfWidth = UIScreen.main.bounds.width / 2
        flowLayout.itemSize = CGSize(width: halfWidth * 0.88, height: halfWidth * 0.88)
        self.encryptoCollectionView.collectionViewLayout = flowLayout
    }
    
    
}

extension EncryptoViewController: UICollectionViewDelegate {
    

}

extension EncryptoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EncryptoCollectionViewCell", for: indexPath) as? EncryptoCollectionViewCell else { return UICollectionViewCell() }
        
        cell.cellLabel.text = codeOption[indexPath.row]
        cell.cellImage.image = codeOptionImage[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 70, height: 70)

    }
}
