//
//  PharseCollectionViewCell.swift
//  To-Do Hub
//
//  Created by Jin younkyum on 2022/05/02.
//

import UIKit

class PharseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var innerCollectionView: UICollectionView!
    
    var pharse = ["All progress takes place outside the comfort zone", "Hello world"]
    var author = ["Michael John Boback", "YounKyum"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        innerCollectionView.dataSource = self
        innerCollectionView.delegate = self
        
        self.innerCollectionView.register(UINib(nibName: "Inner1CollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "Inner1CollectionViewCell")
        self.innerCollectionView.register(UINib(nibName: "Inner2CollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "Inner2CollectionViewCell")
    }

}

extension PharseCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Inner1CollectionViewCell", for: indexPath) as? Inner1CollectionViewCell else { return UICollectionViewCell() }
            cell.pharseLabel.text = pharse[0]
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Inner2CollectionViewCell", for: indexPath) as? Inner2CollectionViewCell else { return UICollectionViewCell() }
            cell.nameLabel.text = pharse[0]
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
