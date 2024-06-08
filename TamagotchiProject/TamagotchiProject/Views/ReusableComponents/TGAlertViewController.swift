//
//  TGAlert.swift
//  TamagotchiProject
//
//  Created by user on 6/7/24.
//

import UIKit

import SnapKit

final class TGAlertViewController: UIViewController {
    let tapGestureView: UIView = UIView()
    let tgAlertBackground: UIView = UIView()
    let tgProfile: TGProfileView = TGProfileView()
    let divider: TGDivider = TGDivider()
    let info: UILabel = UILabel()
    let cancelButton: UIButton = UIButton()
    let actionButton: UIButton = UIButton()
    lazy var buttonStackView: UIStackView = UIStackView(arrangedSubviews: [
        cancelButton,
        actionButton
    ])
    
    weak var tgAlertDelegate: TGAlertDelegate?
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
}


extension TGAlertViewController: CodeBaseBuildable {
    internal func configureHierarchy() {
        view.addSubview(tapGestureView)
        tapGestureView.addSubview(tgAlertBackground)
        tgAlertBackground.addSubview(tgProfile)
        tgAlertBackground.addSubview(divider)
        tgAlertBackground.addSubview(info)
        tgAlertBackground.addSubview(buttonStackView)
    }
    
    internal func configureLayout() {
        tapGestureView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tgAlertBackground.snp.makeConstraints {
            $0.width.equalTo(tapGestureView.snp.width)
                .multipliedBy(0.8)
            $0.height.equalTo(tapGestureView.snp.height)
                .multipliedBy(0.5)
            $0.center.equalTo(tapGestureView.snp.center)
        }
        
        divider.snp.makeConstraints {
            $0.center.equalTo(tgAlertBackground.snp.center)
            $0.width.equalTo(tgAlertBackground.snp.width)
                .multipliedBy(0.8)
        }
        
        tgProfile.snp.makeConstraints {
            $0.size.equalTo(tgAlertBackground.snp.width)
                .multipliedBy(0.5)
            $0.centerX.equalTo(tgAlertBackground.snp.centerX)
            $0.bottom.equalTo(divider.snp.top)
                .offset(-8)
        }
        
        info.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom)
                .offset(16)
            
            $0.width.equalTo(divider.snp.width)
            $0.centerX.equalTo(divider.snp.centerX)
            
            $0.bottom.equalTo(buttonStackView.snp.top)
                .offset(-16)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalTo(tgAlertBackground)
            $0.height.equalTo(50)
        }
    }
    
    internal func configureUI() {
        tapGestureView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundTapped)))
        tapGestureView.backgroundColor = .black.withAlphaComponent(0.3)
        
        tgAlertBackground.backgroundColor = .TGBackgroundColor
        tgAlertBackground.layer.cornerRadius = 8
        
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 0
        buttonStackView.distribution = .fillEqually
        
        info.numberOfLines = 0
        info.textColor = .TGNavyColor
        info.font = .systemFont(ofSize: 12, weight: .semibold)
        info.textAlignment = .center
        info.text = "아직 준비중인 다마고치에요 🌱"
        
        // MARK: corner radius, border 설정, forgroundColor, tapGesture 고치기
        buttonStackView.backgroundColor = .systemGray
        buttonStackView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        buttonStackView.layer.cornerRadius = 8
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        actionButton.setTitle("시작하기", for: .normal)
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    
    
    @objc
    func backgroundTapped() {
        self.dismiss(animated: true)
    }
    
    @objc
    func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @objc
    func actionButtonTapped(_ sender: UIButton) {
        dismiss(animated: true) { [weak self] in
            self?.tgAlertDelegate?.startButtonTapped()
        }
    }
}
