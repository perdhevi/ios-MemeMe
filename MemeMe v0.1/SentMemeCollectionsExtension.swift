//
//  SentMemeCollectionsExtension.swift
//  MemeMe v2.0
//
//  Created by Raditya on 6/24/17.
//  Copyright © 2017 Raditya. All rights reserved.
//

import Foundation
import UIKit

private let reuseIdentifier = "SentMemeCollectionCell"

extension SentMemeCollections {
    // MARK: UICollectionViewDataSource
    
    func setFlowlayout() {
        let space : CGFloat = 3.0
        let w = (view.frame.size.width - (2 * space)) / 3
        let h = (view.frame.size.height - (2 * space)) / 5
        
        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSize(width: w, height: h)
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getMemeCount()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SentMemeCollectionCell
        
        // Configure the cell
        let meme = getMeme(atIndex: indexPath.row)
        cell.image!.image = meme.meme
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewMeme(at: indexPath.row)
    }
    
    
}
