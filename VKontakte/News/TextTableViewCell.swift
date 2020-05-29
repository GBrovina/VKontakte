//
//  TextTableViewCell.swift
//  VKontakte
//
//  Created by Галина  Бровина  on 20.02.2020.
//  Copyright © 2020 Галина  Бровина . All rights reserved.
//

import UIKit

protocol TextTableViewCellDelegate:class {
    func showMoreTapped(indexPath: IndexPath)
    
}

class TextTableViewCell: UITableViewCell {

    weak var delegate:TextTableViewCellDelegate!
    var indexPath:IndexPath?

    
    @IBOutlet weak var textNews: UITextView!
    @IBOutlet weak var textNewsHeight: NSLayoutConstraint!
    @IBOutlet weak var showMoreButton: UIButton!
    @IBAction func showMore(_ sender: Any) {
        guard let index = indexPath else {return}
        delegate?.showMoreTapped(indexPath: index)
    }
    
    func hiddenButton(){
        if textNews.text.count < 200 {
            showMoreButton.isHidden = true
        } else {
            showMoreButton.isHidden = false
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
