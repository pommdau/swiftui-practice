//
//  AnchorView.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/31.
//

import SwiftUI

struct AnchorView: View {
    
    let colors: UnitColors
    
    var body: some View {
        Circle()
            .stroke(colors .frameStroke, lineWidth: 4)
            .background(Circle().foregroundColor(colors.frameFill))
            .frame(width: 44, height: 44)
    }
}

struct _AnchorView: View {
    
    @State var colors: UnitColors = .offUnit
    
    var body: some View {
        
        VStack {
            
            Button {
                withAnimation {
                    colors = .offUnit
                }
            } label: {
                Text("OffUnit")
            }
            
            Button {
                withAnimation {
                    colors = .unit1
                }
            } label: {
                Text("Unit1")
            }
            
            Button {
                withAnimation {
                    colors = .unit2
                }
            } label: {
                Text("Unit2")
            }
            
            Button {
                withAnimation {
                    colors = .unit3
                }
            } label: {
                Text("Unit3")
            }
            
            AnchorView(colors: colors)
        }
    }
}

struct AnchorView_Previews: PreviewProvider {
    static var previews: some View {
        _AnchorView()
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
