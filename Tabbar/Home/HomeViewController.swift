//
//  HomeViewController.swift
//  Tabbar
//
//  Created by LuongTran on 05/07/2022.
//

import UIKit

class HomeViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imgPet = ["pic1", "pic2", "pic3"]
    var frame = CGRect(x: 0, y: 0, width: 0, height: 180)
    
    var data: [String] = []
    let cellName = String(describing: GridOneTableViewCell.self)
    let collName = String(describing: GridCollectionViewCell.self)
    
    var isState = true
    var cellMarginSize = 5.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadData()
        configTableView()
        configCollectionView()
        collectionView.isHidden = true
        customNavigation()
        createScrollViewContent()
        self.view.addSubview(pageControl)
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
    
    func configCollectionView(){
        let nib = UINib(nibName: collName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: collName)
        collectionView.dataSource = self
        collectionView.delegate = self
//        self.setupGridView()
    }
    
//    func setupGridView(){
//        let flow = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
//        flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
//        flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
//    }
    
    func customNavigation(){
        self.navigationController?.navigationBar.topItem?.title = "Home"
        let changeStateButton = UIBarButtonItem(image: UIImage(systemName: "square.grid.2x2.fill"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(changeState))
        changeStateButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = changeStateButton
        navigationController?.addCustomBottomLine(color: UIColor.black, height: 2)
    }
    
    func createScrollViewContent(){
        pageControl.numberOfPages = imgPet.count
        for index in 0..<imgPet.count {
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            let imgView = UIImageView(frame: frame)
            imgView.image = UIImage(named: imgPet[index])
            self.scrollView.addSubview(imgView)
        }
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(imgPet.count)), height: scrollView.frame.size.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }

    @objc func changeState(){
        if(isState){
            let changeStateButton = UIBarButtonItem(image: UIImage(systemName: "rectangle.grid.1x2.fill"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(changeState))
            changeStateButton.tintColor = .black
            self.navigationItem.rightBarButtonItem = changeStateButton
            navigationController?.addCustomBottomLine(color: UIColor.black, height: 2)
            isState = false
            collectionView.isHidden = false
            tableView.isHidden = true
        }else{
            let changeStateButton = UIBarButtonItem(image: UIImage(systemName: "square.grid.2x2.fill"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(changeState))
            changeStateButton.tintColor = .black
            self.navigationItem.rightBarButtonItem = changeStateButton
            navigationController?.addCustomBottomLine(color: UIColor.black, height: 2)
            isState = true
            collectionView.isHidden = true
            tableView.isHidden = false
        }
    }


}

extension UINavigationController
{
    func addCustomBottomLine(color:UIColor,height:Double)
    {
        //Hiding Default Line and Shadow
        navigationBar.setValue(true, forKey: "hidesShadow")
        //Creating New line
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width:0, height: height))
        lineView.backgroundColor = color
        navigationBar.addSubview(lineView)

        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.widthAnchor.constraint(equalTo: navigationBar.widthAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        lineView.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor).isActive = true
        lineView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
    }
}


//Table View
extension HomeViewController: UITableViewDataSource{
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

extension HomeViewController: UITableViewDelegate{
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
        //edit
        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
          print("Edit: \(indexPath.row + 1)")
          completionHandler(true)
        }
        edit.backgroundColor = .gray
        
        // swipe
        let swipe = UISwipeActionsConfiguration(actions: [delete, edit])
        
        return swipe
        
      }

}


//CollectionView
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    //Data
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collName, for: indexPath) as! GridCollectionViewCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.brown.cgColor
        return cell
    }
    //Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor(collectionView.frame.size.width / 2 - 3)
        return CGSize(width: width, height: 274)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    }

    
}
