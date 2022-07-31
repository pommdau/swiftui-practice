//
//  HomeAppView.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/31.
//

import SwiftUI

struct HomeAppView: View {
    var body: some View {
        RopeView(color: .blue, isGlowing: true)
    }
}

struct HomeAppView_Previews: PreviewProvider {
    static var previews: some View {
        HomeAppView()
    }
}
