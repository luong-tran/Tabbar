//
//  GridCollectionViewCell.swift
//  Tabbar
//
//  Created by LuongTran on 14/07/2022.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var btnFavorite: UIButton!
    var isFavorite = true
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnFavorite.setImage(UIImage(systemName: "star.fill"), for: .normal)
        btnFavorite.tintColor = .black
    }

    @IBAction func changeFavorite(_ sender: Any) {
        if(isFavorite){
            btnFavorite.setImage(UIImage(systemName: "star"), for: .normal)
            isFavorite = false
        }else{
            btnFavorite.setImage(UIImage(systemName: "star.fill"), for: .normal)
            isFavorite = true
        }
    }
}
