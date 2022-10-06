//
//  Extensions.swift
//  DynamicTabIndicator
//
//  Created by HIROKI IKEUCHI on 2022/10/06.
//

import SwiftUI

// MARK: - Custom modifier

extension View {
    
    @ViewBuilder
    func offsetX(completion: @escaping (CGFloat) -> ()) -> some View {
        self
            .overlay {
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX  // 現在のTabのleadingの位置
                    Color.clear
                        .preference(key: OffsetKey.self, value: minX)
                        .onPreferenceChange(OffsetKey.self) { value in
                            completion(value)
                        }
                }
            }
    }
}

// MARK: - Offset preference key
struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    // reduce: 子Viewが入れた値から親Viewが受け取る値への変換処理を書きます。
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()  // 新しい値で上書きするだけ
    }
    
}
