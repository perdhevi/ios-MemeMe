//
//  SentMemeTableViewCell.swift
//  MemeMe v2.0
//
//  Created by Raditya on 6/20/17.
//  Copyright © 2017 Raditya. All rights reserved.
//

import UIKit

class SentMemeTableViewCell: UITableViewCell {


    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var top: UILabel!
    @IBOutlet weak var bottom: UILabel!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupCellWith(meme:Meme){
        memeImage.image = meme.meme
        top.text = meme.topText
        bottom.text = meme.bottomText
        
    }

}
