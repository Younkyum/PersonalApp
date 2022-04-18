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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("Anagram")
        case 1:
            let newVC = self.storyboard?.instantiateViewController(identifier: "CaesarViewController")
            newVC?.modalTransitionStyle = .coverVertical
            newVC?.modalPresentationStyle = .automatic
            self.present(newVC!, animated: true, completion: nil)
        case 2:
            print("affine")
        case 3:
            print("hash")
        default:
            print("error")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
            if let cell = collectionView.cellForItem(at: indexPath) as? EncryptoCollectionViewCell {
                let pressedDownTransform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3, options: [.curveEaseInOut], animations: { cell.transform = pressedDownTransform })

            }
    }
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
            if let cell = collectionView.cellForItem(at: indexPath) as? EncryptoCollectionViewCell {
                let originalTransform = CGAffineTransform(scaleX: 1, y: 1)
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3, options: [.curveEaseInOut], animations: { cell.transform = originalTransform })
            }
    }
}
