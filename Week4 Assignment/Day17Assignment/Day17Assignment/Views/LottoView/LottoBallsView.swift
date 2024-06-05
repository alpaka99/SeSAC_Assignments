//
//  LottoBallsView.swift
//  Day17Assignment
//
//  Created by user on 6/5/24.
//

import UIKit

import SnapKit

// MARK: 공들을 전부 하나의 type으로 만들어줄 수 있지 않을까?
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
        configureData(nil)
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
        balls.forEach { ball in
            ball.snp.makeConstraints { make in
                make.width.equalTo(self.snp.width)
                    .multipliedBy(0.1)
                make.height.equalTo(ball.snp.width)
                    .multipliedBy(1)
            }
        }
        
        ballStack.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
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
            ball.font = .systemFont(ofSize: 16, weight: .bold)
        }
        firstBall.backgroundColor = .systemYellow
        secondBall.backgroundColor = .systemTeal
        thirdBall.backgroundColor = .systemTeal
        fourthBall.backgroundColor = .systemPink
        fifthBall.backgroundColor = .systemPink
        sixthBall.backgroundColor  = .systemGray
        plusBall.backgroundColor = .clear
        bonusBall.backgroundColor = .systemGray
        
        plusBall.textColor = .black
    }
    
    internal func configureData(_ data: LottoInfo?) {
        if let data = data {
            firstBall.text = String(data.drwtNo1)
            secondBall.text = String(data.drwtNo2)
            thirdBall.text = String(data.drwtNo3)
            fourthBall.text = String(data.drwtNo4)
            fifthBall.text = String(data.drwtNo5)
            sixthBall.text = String(data.drwtNo6)
            bonusBall.text = String(data.bnusNo)
        } else {
            balls.forEach { ball in
                ball.text = "?"
            }
        }
        plusBall.text = "+"
    }
}


enum BallType: CaseIterable {
    case first
    case second
    case third
    case fourth
    case fifth
    case sixth
    case plus
    case bonus
    
    var key: String {
        switch self {
        case .first:
            return "drwtNo1"
        case .second:
            return "drwtNo2"
        case .third:
            return "drwtNo3"
        case .fourth:
            return "drwtNo4"
        case .fifth:
            return "drwtNo5"
        case .sixth:
            return "drwtNo6"
        case .plus:
            return "plus"
        case .bonus:
            return "bnusNo"
        }
    }
}
