//
//  SettingViewController.swift
//  Tabbar
//
//  Created by LuongTran on 17/07/2022.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnLogOut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        customNavigation()
        configTableView()
    }


    func customNavigation(){
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = "Settings"
    }
    
    func configTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.link
    }
    
    @IBAction func logOutView(_ sender: Any) {
        // create the alert
        let alert = UIAlertController(title: "Alert", message: "You want to Log out?", preferredStyle: UIAlertController.Style.alert)

        // add an action (button)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: nil))

        // show the alert
            self.present(alert, animated: true, completion: nil)
    }
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        cell.textLabel?.text = "Setting \(indexPath.row + 1)"
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        return cell
    }
}
