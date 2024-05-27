//
//  MagazineTableViewController.swift
//  TravelMagazineProject
//
//  Created by user on 5/26/24.
//

import Kingfisher
import UIKit

final class MagazineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    
    private var magazineData: MagazineInfo = MagazineInfo()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "SeSAC Magazine"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MagazineTableViewCell.self, forCellReuseIdentifier: MagazineTableViewCell.getReuseIdentifier())
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: MagazineTableViewCell.getReuseIdentifier(), for: indexPath) as? MagazineTableViewCell {
            
            let data = magazineData.magazine[indexPath.row]
            
            // MARK: 이 부분 Cell쪽으로 옮겨서 함수로 작업하기
            
            let url = URL(string: data.photo_image)
            
            cell.cellImage.kf.setImage(with: url)
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
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailMagazineViewController()
        detailViewController.setTextLabelText(magazineData.magazine[indexPath.row].link)
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
