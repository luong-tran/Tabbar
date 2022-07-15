//
//  DetailViewController.swift
//  Tabbar
//
//  Created by LuongTran on 14/07/2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var titleBar = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        customNaviDetail()
    }

    func customNaviDetail(){
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = titleBar
    }

}
