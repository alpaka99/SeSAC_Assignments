//
//  CustomTableViewCell.swift
//  Day8Assignments
//
//  Created by user on 5/23/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    // 셀 id
    static let cellId = "CellId"
    
    let leadingImage: UIImageView = UIImageView()
    var trailingView: UIImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func layoutCustomCell() {
        self.addSubview(leadingImage)
        self.addSubview(trailingView)
        
        leadingImage.translatesAutoresizingMaskIntoConstraints = false
        trailingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leadingImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            leadingImage.heightAnchor.constraint(equalTo: self.heightAnchor),
            leadingImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            leadingImage.widthAnchor.constraint(equalTo: leadingImage.heightAnchor, multiplier: 1),
            
            
            trailingView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            trailingView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            trailingView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
