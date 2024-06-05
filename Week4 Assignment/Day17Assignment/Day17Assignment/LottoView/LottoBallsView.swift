//
//  LottoBallsView.swift
//  Day17Assignment
//
//  Created by user on 6/5/24.
//

import UIKit

import SnapKit

final class LottoBallsView: UIView {
    let firstBall: UILabel = UILabel()
    let secondBall: UILabel = UILabel()
    let thirdBall: UILabel = UILabel()
    let fourthBall: UILabel = UILabel()
    let fifthBall: UILabel = UILabel()
    let sixthBall: UILabel = UILabel()
    let plusBall: UILabel = UILabel()
    let bonusBall: UILabel = UILabel()
    
    lazy var balls: [UILabel] = [
        firstBall,
        secondBall,
        thirdBall,
        fourthBall,
        fifthBall,
        sixthBall,
        plusBall,
        bonusBall
    ]
    lazy var ballStack: UIStackView = UIStackView(arrangedSubviews: balls)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureUI()
        configureData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        balls.forEach { ball in
            ball.layer.cornerRadius = ball.frame.width / 2
        }
    }
    
    private func configureHierarchy() {
        self.addSubview(ballStack)
    }
    
    private func configureLayout() {
        ballStack.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(ballStack.snp.width)
                .multipliedBy(0.1)
        }
        
        
        balls.forEach { ball in
            ball.snp.makeConstraints { make in
                make.width.equalTo(ballStack.snp.width)
                    .multipliedBy(0.1)
                make.height.equalTo(ball.snp.width)
                    .multipliedBy(1)
            }
        }
    }
    
    private func configureUI() {
        ballStack.spacing = 4
        ballStack.axis = .horizontal
        ballStack.distribution = .equalSpacing
        
        balls.forEach { ball in
            ball.textColor = .white
            
            ball.textAlignment = .center
            ball.clipsToBounds = true
            ball.backgroundColor = .systemRed
            ball.font = .systemFont(ofSize: 16, weight: .bold)
        }
        
        plusBall.backgroundColor = .clear
        plusBall.textColor = .black
    }
    
    private func configureData() {
        balls.forEach { ball in
            ball.text = "45"
        }
        plusBall.text = "+"
    }
}
