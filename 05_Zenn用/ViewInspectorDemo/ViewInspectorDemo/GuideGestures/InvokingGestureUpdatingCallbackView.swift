//
//  InvokingGestureUpdatingCallbackView.swift
//  ViewInspectorDemo
//
//  Created by Hiroki Ikeuchi on 2023/01/19.
//

import SwiftUI
import Combine

struct InvokingGestureUpdatingCallbackView: View {
    @GestureState var isDetectingLongPress = false
    
    internal let inspection = Inspection<Self>()
    internal let publisher = PassthroughSubject<Void, Never>()
    
    var body: some View {
        let press = LongPressGesture(minimumDuration: 1)
            .updating($isDetectingLongPress) { currentState, gestureState, transaction in
                gestureState = currentState
            }
        
        return Circle()
            .fill(isDetectingLongPress ? Color.yellow : Color.green)
            .frame(width: 100, height: 100, alignment: .center)
            .gesture(press)
            .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
            .onReceive(publisher) { }
    }
}

struct InvokingGestureUpdatingCallbackView_Previews: PreviewProvider {
    static var previews: some View {
        InvokingGestureUpdatingCallbackView()
    }
}
