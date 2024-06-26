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
        
        setNavigationUI(.magazine)
        
        setDelegate()
        registerCells()
        
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerCells() {
        tableView.register(MagazineTableViewCell.self, forCellReuseIdentifier: MagazineTableViewCell.reuseIdentifier)
    }
    
    private func setNavigationUI(_ type: NavigationItemType) {
        navigationItem.title = type.title
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazineData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MagazineTableViewCell.reuseIdentifier, for: indexPath) as? MagazineTableViewCell {
            
            let data = magazineData.magazine[indexPath.row]
            
            // MARK: 이 부분 cell에 넣기
            if let url = URL(string: data.photo_image) {
                DataManager.shared.fetchImage(url) { [weak cell] image in
                    cell?.magazineImage.image = image
                }
            }
            cell.title.text = data.title
            cell.subtitle.text = data.subtitle
            cell.dateLabel.text = data.date
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath) as UITableViewCell
            
            cell.textLabel?.text = BasicCellInfo.text
            
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
