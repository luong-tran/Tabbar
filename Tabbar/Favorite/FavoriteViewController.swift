//
//  FavoriteViewController.swift
//  Tabbar
//
//  Created by LuongTran on 13/07/2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    let cellName = String(describing: GridOneTableViewCell.self)
    var data: [String] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        customNavigation()
        loadData()
        configTableView()
    }
    
    func customNavigation(){
        self.navigationController?.navigationBar.topItem?.title = "Favorite"
        navigationController?.addCustomBottomLine(color: UIColor.black, height: 2)
        let deleteButton = UIBarButtonItem(image: UIImage(systemName: "trash.fill"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(delAllRow))
        deleteButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = deleteButton
        navigationController?.addCustomBottomLine(color: UIColor.black, height: 2)
    }
    
    func loadData(){
        guard let path = Bundle.main.url(forResource: "Data", withExtension: "plist")
            else { return }
        guard let dataContacts = NSArray(contentsOf: path) as? [String]
            else { return }
        data = dataContacts
    }
    
    func configTableView(){
        let nib = UINib(nibName: cellName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellName)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = UIColor.clear
    }

    @objc func delAllRow(){
        let alert = UIAlertController(title: "UIAlertController", message: "Would you like to continue learning how to use iOS alerts?", preferredStyle: UIAlertController.Style.alert)

        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
            self.data.removeAll()
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
}


//Table View
extension FavoriteViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName) as! GridOneTableViewCell
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.titleBar = "Caffe đèn mờ"
        self.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // delete
        let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, completionHandler) in
            tableView.beginUpdates()
            self.data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            completionHandler(true)
        }
        delete.backgroundColor = .red
        
        // swipe
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        
        return swipe
        
      }

}
