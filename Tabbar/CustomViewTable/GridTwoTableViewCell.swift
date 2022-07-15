//
//  GridTwoTableViewCell.swift
//  Tabbar
//
//  Created by LuongTran on 14/07/2022.
//

import UIKit

class GridTwoTableViewCell: UITableViewCell {

    @IBOutlet weak var btnFavorite: UIButton!
    
    var isFavorite = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnFavorite.setImage(UIImage(systemName: "star.fill"), for: .normal)
        btnFavorite.tintColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
