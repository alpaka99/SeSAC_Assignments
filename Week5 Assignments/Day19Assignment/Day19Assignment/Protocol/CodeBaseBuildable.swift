//
//  CodeBaseBuildable.swift
//  Day19Assignment
//
//  Created by user on 6/11/24.
//

protocol CodeBaseBuildable {
    func configureHierarchy()
    func configureLayout()
    func configureUI()
    func configureData<T>(_ data: T)
}
