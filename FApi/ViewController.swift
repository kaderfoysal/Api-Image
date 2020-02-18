//
//  ViewController.swift
//  FApi
//
//  Created by apple on 2/17/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    
    var imageName = [String]()
    var modelData = [mymodel]()
    
    
    func loadData(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        URLSession.shared.dataTask(with: url!){
            (data,response,error) in
            if error == nil{
                do{
                    let myData = try! JSONDecoder().decode([mymodel].self, from: data!)
                    DispatchQueue.main.async {
                        for n in myData{
                            self.imageName.append(n.url)
                        }
                        self.tableView.reloadData()
                    }
                }catch{
                    print("nothing")
                }
            }
        }.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        let url = URL(string: imageName[indexPath.row])
        
        DispatchQueue.global().async {
            
            DispatchQueue.main.async {
                cell.cellImage.af_setImage(withURL: url!)
            }
            
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        // Do any additional setup after loading the view.
    }


}

