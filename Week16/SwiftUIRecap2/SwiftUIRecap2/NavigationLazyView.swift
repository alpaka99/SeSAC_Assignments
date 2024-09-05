//
//  NavigationLazyView.swift
//  SwiftUIRecap2
//
//  Created by user on 9/6/24.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    
    let wrappedView: () -> Content
    
    var body: some View {
        wrappedView()
    }
    
    init(wrappedView: @autoclosure @escaping () -> Content) {
        self.wrappedView = wrappedView
        print("NavigationLazyView Init")
    }
}
