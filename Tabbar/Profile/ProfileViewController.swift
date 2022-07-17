//
//  ProfileViewController.swift
//  Tabbar
//
//  Created by LuongTran on 13/07/2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnPost: UIButton!
    @IBOutlet weak var btnFollower: UIButton!
    @IBOutlet weak var btnFollowing: UIButton!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    let collName = String(describing: ImageCollectionViewCell.self)
    let cellName = String(describing: FollowerTableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.isHidden = true
        customNavigation()
        customStyle()
        configCollectionView()
        configTableView()
    }
    
    func customNavigation(){
        self.navigationController?.navigationBar.topItem?.title = "Profile"
        navigationController?.addCustomBottomLine(color: UIColor.black, height: 2)
        let settingButton = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(settingButtonBar))
        settingButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = settingButton
        navigationController?.addCustomBottomLine(color: UIColor.black, height: 2)
    }
    
    @objc func settingButtonBar(){
        let settingViewController = SettingViewController()
        self.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(settingViewController, animated: true)
    }
    
    func customStyle(){
        btnEdit.backgroundColor = .clear
        btnEdit.layer.cornerRadius = 5
        btnEdit.layer.borderWidth = 1
        btnEdit.layer.borderColor = UIColor.tintColor.cgColor
        
        btnPost.backgroundColor = .link
        btnPost.tintColor = .white
        btnPost.layer.cornerRadius = 5
        btnPost.layer.borderWidth = 2
        btnPost.layer.borderColor = UIColor.black.cgColor
        
        btnFollower.backgroundColor = .white
        btnFollower.tintColor = .black
        btnFollower.layer.cornerRadius = 5
        btnFollower.layer.borderWidth = 2
        btnFollower.layer.borderColor = UIColor.black.cgColor
        
        btnFollowing.backgroundColor = .white
        btnFollowing.tintColor = .black
        btnFollowing.layer.cornerRadius = 5
        btnFollowing.layer.borderWidth = 2
        btnFollowing.layer.borderColor = UIColor.black.cgColor
        

        imgAvatar.layer.cornerRadius = imgAvatar.bounds.size.width / 2
        imgAvatar.clipsToBounds = true

        lblName.text = "Tien Le P."
    }
    
    func configCollectionView(){
        let nib = UINib(nibName: collName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: collName)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configTableView(){
        let nib = UINib(nibName: cellName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellName)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = UIColor.clear
    }

    @IBAction func actionPost(_ sender: Any) {
        btnPost.backgroundColor = .link
        btnPost.tintColor = .white
        btnFollower.backgroundColor = .white
        btnFollower.tintColor = .black
        btnFollowing.backgroundColor = .white
        btnFollowing.tintColor = .black
        
        collectionView.isHidden = false
        tableView.isHidden = true
        
    }
    @IBAction func actionFollower(_ sender: Any) {
        btnFollower.backgroundColor = .link
        btnFollower.tintColor = .white
        btnPost.backgroundColor = .white
        btnPost.tintColor = .black
        btnFollowing.backgroundColor = .white
        btnFollowing.tintColor = .black
        
        collectionView.isHidden = true
        tableView.isHidden = false
    }
    @IBAction func actionFollowing(_ sender: Any) {
        btnFollowing.backgroundColor = .link
        btnFollowing.tintColor = .white
        btnPost.backgroundColor = .white
        btnPost.tintColor = .black
        btnFollower.backgroundColor = .white
        btnFollower.tintColor = .black
        
        collectionView.isHidden = true
        tableView.isHidden = false
    }
    
}

//Collection View
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collName, for: indexPath) as! ImageCollectionViewCell
        cell.imgView.image = UIImage(named: "pic1")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width/3) - 3, height: (view.frame.size.width/3))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

//Table View
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName) as! FollowerTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
