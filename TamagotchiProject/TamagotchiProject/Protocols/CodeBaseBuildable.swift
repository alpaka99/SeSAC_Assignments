//
//  CodeBaseBuildable.swift
//  TamagotchiProject
//
//  Created by user on 6/7/24.
//

import UIKit


/* MARK: Protocl vs Access Control
 protocol의 membere들은 internal, public, open 해야한다. 왜냐하면 protocol이라는것 자체가 채택하는 대상의 형태를 구체적으로 묘사하고 있어야하는데, private은 숨기려고 하는것이기 때문에 두 개념이 상충하게 된다. 만약 private 하게 숨겨야하는 형태라면 oop에서는 추상클래스를 선언하고 상속받는 형태가 더 적합할 수 있다.
 -> 이 부분에 대해서는 좀 더 생각해볼것. 지금까지 했던것처럼 private 선언을 해서 캡슐화를 더 할지, 아니면 프로토콜로 선언 후 채택해서 개발자들이 더 쉽게 구현할 수 있게할지
 */
internal protocol CodeBaseBuildable {
    func configureHierarchy()
    func configureLayout()
    func configureUI()
}

