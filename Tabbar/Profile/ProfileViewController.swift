//
//  ProfileViewController.swift
//  Tabbar
//
//  Created by LuongTran on 13/07/2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        customNavigation()
    }
    
    func customNavigation(){
        self.navigationController?.navigationBar.topItem?.title = "Profile"
        navigationController?.addCustomBottomLine(color: UIColor.black, height: 2)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
