//
//  MemberCollectionViewCell.swift
//  GitColab
//
//  Created by Jin younkyum on 2022/05/26.
//

import UIKit

class MemberCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var commitLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var todayCommitLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupLayout() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 10
    }
}
