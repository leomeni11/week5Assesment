//
//  ViewController.swift
//  Week 5 Assessment(G)
//
//  Created by george chin fu hou on 24/02/2017.
//  Copyright © 2017 George Chin. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var placeTableView: UITableView!{
        didSet{
            placeTableView.delegate = self
            placeTableView.dataSource = self
        }
    }
    var city = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        fetchCity()
    
    }
    
    func fetchCity(){
        
        let url = "https://feeds.citibikenyc.com/stations/stations.json"
        
        Alamofire.request(url, method: .get).validate().responseJSON{ ( response )  in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                if let blogs = json.array{
                    for blog in blogs {
                        let newBlog = Blog(json: blog)
                        //Blog.allBlog.append(newBlog)
                        Blog.allBlog.append(newBlog)
                      
                    }
                    
                    self.blogTableView.reloadData()
                }
                
                //        print(*JSON: \(json)*)
                print(json["stationBeanList"].string)
            case .failure(let error):
                print(error)
                
            }
        }
        
    }
}
    


extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return city.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { return UITableViewCell() }
        
        cell.textLabel?.text = city[indexPath.row]
        
        return cell
}

}
