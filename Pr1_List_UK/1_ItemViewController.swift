//
//  ItemViewController.swift
//  Pr1_List_UK
//
//  Created by Students on 06.03.2023.
//

import UIKit

class ItemViewController: UIViewController {

    @IBOutlet var label: UILabel!
    
    var item: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = item
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))
    }
    
    @objc func deleteTask() {
//        let newCount = count - 1
//        UserDefaults().setValue(newCount, forKey: "count")
//        UserDefaults().setValue(nil, forKey: "item_\(currentPosition)")
        
    }
}
