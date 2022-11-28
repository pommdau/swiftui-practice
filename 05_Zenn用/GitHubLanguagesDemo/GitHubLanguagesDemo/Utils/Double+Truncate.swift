//
//  Double+Truncate.swift
//  GitHubLanguagesDemo
//
//  Created by HIROKI IKEUCHI on 2022/11/26.
//

import Foundation

extension Double {
    // [Swiftで四捨五入・切り上げ・切り捨てをする方法 \(\+ 小数点をずらす\)](https://swift.tecc0.com/?p=476)
    // [Swiftで小数点をx位置に切り捨てる方法](https://jpcodeqa.com/q/0d002271fee9569c51be71f7fafc9cf9)
    /*
     e.g.
     let num = 1.23456789
     print(num.truncate(places: 2))  // 1.23
     print(num.truncate(places: 6))  // 1.234568
     */
    func truncate(places : Int)-> Double {
        
        var result: Double = self
        result = result * pow(10.0, Double(places))
        result = result.rounded()
        result = result / pow(10.0, Double(places))
                                            
        return result
    }
}
