//
//  MagazineTableViewController.swift
//  TravelMagazineProject
//
//  Created by user on 5/26/24.
//

import UIKit

class MagazineTableViewController: UITableViewController {
    
    private var magazineData: MagazineInfo = MagazineInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "SeSAC Magazine"
        
        tableView.register(MagazineTableViewCell.self, forCellReuseIdentifier: MagazineTableViewCell.getReuseIdentifier())
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: MagazineTableViewCell.getReuseIdentifier(), for: indexPath) as? MagazineTableViewCell {
            
            let data = magazineData.magazine[indexPath.row]
            
//            cell.cellImage.image = UIImage(named: data.photo_image)
            cell.title.text = data.title
            cell.subtitle.text = data.subtitle
            cell.dateLabel.text = data.date
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as UITableViewCell
            
            cell.textLabel?.text = "Something went wrong...😞"
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
