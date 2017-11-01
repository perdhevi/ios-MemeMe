//
//  SentMemeExtension.swift
//  MemeMe v2.0
//
//  Created by Raditya on 6/20/17.
//  Copyright © 2017 Raditya. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func addNewMeme() -> MemeEditorViewController{
        
        let meme = storyboard?.instantiateViewController(withIdentifier: "MemeEditorVC")
        
        present(meme!, animated: true)
        
        return meme as! MemeEditorViewController
    }
    
    func getMemeCount() -> Int {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.meme.count
    }
    
    func getMeme(atIndex index:Int) -> Meme {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let meme = appDelegate.meme[index]
        
        return meme
    }
    
    func replaceMeme(at index:Int, meme:Meme){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.meme[index] = meme
    }
    
    func deleteMeme(at index:Int) -> Meme{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let meme = appDelegate.meme.remove(at: index)
        
        return meme
    }
    
    func viewMeme(at index:Int) {
        let memeVC = storyboard?.instantiateViewController(withIdentifier: "MemeViewerVC") as! MemeViewerVC
        memeVC.memeIndex = index
        navigationController?.pushViewController(memeVC, animated: true)
    }
    
    func editMeme(index:Int) {
        let memeEditor = storyboard?.instantiateViewController(withIdentifier: "MemeEditorVC") as! MemeEditorViewController
        let meme = getMeme(atIndex: index)
        memeEditor.editingMeme = meme
        memeEditor.editingIndex = index
        present(memeEditor, animated: true)
    }
}
