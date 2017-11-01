//
//  SentMemeCollections.swift
//  MemeMe v2.0
//
//  Created by Raditya on 6/18/17.
//  Copyright © 2017 Raditya. All rights reserved.
//

import UIKit


class SentMemeCollections: UICollectionViewController {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"+", style: .plain, target:self, action : #selector(addNewMeme))
        
        setFlowlayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.collectionView!.reloadData()
    }

    
}
