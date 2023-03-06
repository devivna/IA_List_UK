//
//  AnotherViewController.swift
//  Pr1_List_UK
//
//  Created by Students on 06.03.2023.
//

import UIKit

class AnotherViewController: UIViewController {

    // create UITableView from code -> register cell
    // ! you need to "call" constant
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var items = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // if items has elements typed earlier in previous versions of this app -> show me
        self.items = UserDefaults.standard.stringArray(forKey: "items") ?? []
        
        // set title into Navigation Contoller
        self.title = "To Do list"
        
        // add tableView to View
        view.addSubview(table)
        
        // conform tableView to dataSource
        table.dataSource = self
        
        // add Bar Button Item (add) with system Image
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapAdd))
    }
    
    // set frame for TableView : all the screen
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }

    // add functionality to  Bar Button Item : add -> alert: TextField + Cancel + Done
    @objc
    private func didTapAdd() {
        
        let alert = UIAlertController(
            title: "New Item",
            message: "Enter new to do list item",
            preferredStyle: .alert) // preferredStyle: .actionSheet
        
        alert.addTextField { field in
            field.placeholder = "Enter item ..."
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self] (_) in
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    DispatchQueue.main.async {
                        var currentItems = UserDefaults.standard.stringArray(forKey: "items") ?? []
                        currentItems.append(text)
                        UserDefaults.standard.setValue(currentItems, forKey: "items")
                        self?.items.append(text)
                        self?.table.reloadData()
                    }
                    //print(text)
                }
            }
        }))
        
        // show alert
        present(alert, animated: true)
    }
    
}

// dataSource: count: numbers of items
//             cell: text in items
extension AnotherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}
