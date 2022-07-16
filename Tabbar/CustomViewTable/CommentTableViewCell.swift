//
//  CommentTableViewCell.swift
//  Tabbar
//
//  Created by LuongTran on 15/07/2022.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        customStyle()
    }
    
    func customStyle(){
        imgAvatar.layer.cornerRadius = imgAvatar.bounds.size.width / 2
        imgAvatar.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
