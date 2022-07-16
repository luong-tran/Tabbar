//
//  DetailViewController.swift
//  Tabbar
//
//  Created by LuongTran on 14/07/2022.
//

import UIKit
import MapKit
import CoreLocation

class DetailViewController: UIViewController, MKMapViewDelegate {
    
    var titleBar = ""
    let coordinate = CLLocationCoordinate2D(latitude: 40.728, longitude: -74)
    let cellName = String(describing: CommentTableViewCell.self)
    
    var dataName = [("Tien Le P."), ("Tam Nguyen M."), ("Linh Vo D.")]
    var dataDay = [("16 days ago"), ("17 days ago"), ("18 days ago")]
    var dataComment = [
        ("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum"),
        ("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum"),
        ("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")]
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        customNaviDetail()
        customMap()
        configTableView()
    }

    func customNaviDetail(){
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = titleBar
    }

    func customMap(){
        mapView.setRegion(MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(
                latitudeDelta: 0.1,
                longitudeDelta: 0.1)),
        animated: false)
        
        mapView.delegate = self
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = "Hello"
        pin.subtitle = "Are you still here?"
        mapView.addAnnotation(pin)
    }
    
    func configTableView(){
        let nib = UINib(nibName: cellName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellName)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = UIColor.clear
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else{
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "customMap")
        if annotationView == nil{
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customMap")
            annotationView?.canShowCallout = true
        }else{
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(systemName: "mappin")
        annotationView?.tintColor = .red
        
        return annotationView
    }
}


//Table View
extension DetailViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataName.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName) as! CommentTableViewCell
        
        cell.lblName.text = self.dataName[indexPath.row]
        cell.lblDay.text = self.dataDay[indexPath.row]
        cell.lblComment.text = self.dataComment[indexPath.row]
        return cell
    }
}

extension DetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
