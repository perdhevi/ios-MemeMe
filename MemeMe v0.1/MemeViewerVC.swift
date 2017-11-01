//
//  MemeViewerVC.swift
//  MemeMe v2.0
//
//  Created by Raditya on 6/21/17.
//  Copyright © 2017 Raditya. All rights reserved.
//

import UIKit

class MemeViewerVC: UIViewController {

    
    var memeIndex : Int = -1
    
    @IBOutlet weak var memeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"EDIT", style: .plain, target:self, action : #selector(editThisMeme))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        let meme = getMeme(atIndex: memeIndex)
        memeImage.image = meme.meme        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func editThisMeme(){
        editMeme(index:memeIndex)
    }
    

}
