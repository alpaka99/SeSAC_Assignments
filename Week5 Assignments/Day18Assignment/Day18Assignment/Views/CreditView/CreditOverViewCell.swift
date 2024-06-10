//
//  CreditOverViewCell.swift
//  Day18Assignment
//
//  Created by user on 6/10/24.
//

import UIKit

import SnapKit

final class CreditOverViewCell: UITableViewCell {
    let overview: UILabel = UILabel()
    let dropDownButton: UIButton = UIButton()
    var overviewMode: OverViewMode = .shorten {
        didSet {
            changeUI() {
                delegate?.dropDownButtonTapped()
            }
        }
    }
    
    weak var delegate: CreditOverViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func dropDownButtonTapped(_ sender: UIButton) {
        switch overviewMode {
        case .shorten:
            overviewMode = .full
        case .full:
            overviewMode = .shorten
        }
    }
}


extension CreditOverViewCell: CodeBaseBuilldable {
    func configureHierarchy() {
        contentView.addSubview(overview)
        contentView.addSubview(dropDownButton)
    }
    
    func configureLayout() {
        overview.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(contentView)
                .inset(16)
        }
        
        dropDownButton.snp.makeConstraints {
            $0.top.equalTo(overview.snp.bottom)
            $0.horizontalEdges.equalTo(overview.snp.horizontalEdges)
            $0.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
    func configureUI() {
        overview.text = "Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview Overview "
        overview.numberOfLines = 2
        
        dropDownButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        dropDownButton.backgroundColor = .systemPink
        dropDownButton.addTarget(self, action: #selector(dropDownButtonTapped), for: .touchUpInside)
        
    }
    
    func changeUI(completion: ()->()) {
        switch overviewMode {
        case .shorten:
            overview.numberOfLines = 2
            dropDownButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        case .full:
            overview.numberOfLines = 0
            dropDownButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        }
        
        completion()
    }
}

enum OverViewMode {
    case shorten
    case full
}


protocol CreditOverViewCellDelegate: AnyObject {
    func dropDownButtonTapped()
}
