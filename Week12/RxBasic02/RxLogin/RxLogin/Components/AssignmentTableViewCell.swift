//
//  AssignmentTableViewCell.swift
//  RxLogin
//
//  Created by user on 8/5/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class AssignmentTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()
    
    static let identifier = "AssignmentTableViewCell"
    
    let checkButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        return button
    }()
    
    let title = {
        let label = UILabel()
        return label
    }()
    
    let favoriteButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    
    func configureUI() {
        contentView.addSubview(checkButton)
        contentView.addSubview(title)
        contentView.addSubview(favoriteButton)
        
        checkButton.snp.makeConstraints { btn in
            btn.leading.equalTo(contentView.safeAreaLayoutGuide)
            btn.centerY.equalTo(contentView.safeAreaLayoutGuide)
            btn.size.equalTo(44)
        }
        
        title.snp.makeConstraints { label in
            label.leading.equalTo(checkButton.snp.trailing)
                .offset(8)
            label.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        favoriteButton.snp.makeConstraints { btn in
            btn.trailing.equalTo(contentView.safeAreaLayoutGuide)
                .inset(8)
            btn.centerY.equalTo(contentView.safeAreaLayoutGuide)
            btn.size.equalTo(44)
        }
    }
    
    func configureData(cellData: CellData) {
        checkButton.setImage(UIImage(systemName: cellData.isChecked ? "checkmark.square.fill" : "checkmark.square"), for: .normal)
        favoriteButton.setImage(UIImage(systemName: cellData.isFavorite ? "star.fill" : "star"), for: .normal)
        title.text = cellData.title
    }
}
