//
//  RopeViewWithAnimation.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/07.
//

import SwiftUI


struct RopeViewWithAnimation: View {
    
    // MARK: - Properties
    
    // MARK: Private Properties
    
    private let pointRadius: CGFloat = 24
    @ObservedObject private var pointsManager =
    PointsManager(pointP0: .init(x: 100, y: 100),
                  pointP2: .init(x: 300, y: 150))
    @State private var showingSupportViews = true
        
    // MARK: Public Properties
    
    // MARK: - View
    
    var body: some View {
        
        ZStack {
            TimelineView(.periodic(from: Date(), by: pointsManager.frameRate)) { context in
                ZStack {
                    QuadraticBezierLine()
                    if showingSupportViews {
                        AuxiliaryLine()
                    }
                    Points()
                    ControlView()
                        .padding()
                        .offset(y: 200)
                        .zIndex(-1)
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            pointsManager.startTimer()
        }
        .onDisappear {
            pointsManager.stopTimer()
        }
    }
}

// MARK: - ViewBuilders

extension RopeViewWithAnimation {
    
    @ViewBuilder
    private func Point(label: String,
                       offset: CGSize = .init(width: 30, height: 0),
                       color: Color,
                       position: CGPoint) -> some View {
        ZStack {
            Circle()
                .frame(width: pointRadius, height: pointRadius)
                .foregroundColor(color)
            Text(label)
                .foregroundColor(.black)
                .offset(offset)
                .frame(minWidth: 40)
        }
        .position(position)
    }
    
    @ViewBuilder
    private func Points() -> some View {
        Point(label: "P0", color: .red, position: pointsManager.pointP0)
            .gesture(dragGestureForPointP0)
        
        Point(label: "P2", color: .red, position: pointsManager.pointP2)
            .gesture(dragGestureForPointP2)
        
        if showingSupportViews {
            Point(label: "P1", color: .green, position: pointsManager.pointP1)
            Point(label: "ControlPoint",
                  offset: .init(width: 40, height: 24),
                  color: .red,
                  position: pointsManager.controlPoint.point)
        }
    }
    
    @ViewBuilder
    private func QuadraticBezierLine() -> some View {
        Path { path in
            path.move(to: pointsManager.pointP0)
            path.addQuadCurve(to: pointsManager.pointP2,
                              control: pointsManager.controlPoint.point)
            path.addLine(to: pointsManager.pointP2)
        }
        .stroke(lineWidth: 6)
        .foregroundStyle(
            .linearGradient(
                colors: [.pink, .blue, .pink],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
    }
    
    // 補助線
    @ViewBuilder
    private func AuxiliaryLine() -> some View {
        Path { path in
            path.move(to: pointsManager.pointP0)
            path.addLine(to: pointsManager.controlPoint.point)
            path.addLine(to: pointsManager.pointP2)
        }
        .stroke(lineWidth: 6)
        .foregroundColor(.gray.opacity(0.5))
    }
    
    @ViewBuilder
    private func ControlView() -> some View {
        VStack(alignment: .leading) {
            Toggle("Support Views", isOn: $showingSupportViews)
            
            VStack(alignment: .leading) {
                Text("Stiffness(k): \(pointsManager.spring.k)")
                Slider(value: $pointsManager.spring.k,
                       in: -300...(-10),
                       step: 1,
                       minimumValueLabel: Text("-300"),
                       maximumValueLabel: Text("-10"),
                       label: { EmptyView() })
            }
            
            VStack(alignment: .leading) {
                Text("Mass(m): \(pointsManager.controlPoint.mass)")
                Slider(value: $pointsManager.controlPoint.mass,
                       in: 1...10,
                       step: 1,
                       minimumValueLabel: Text("1"),
                       maximumValueLabel: Text("10"),
                       label: { EmptyView() })
            }
            
            VStack(alignment: .leading) {
                Text("Dumping(d): \(pointsManager.spring.d)")
                Slider(value: $pointsManager.spring.d,
                       in: -5...0,
                       step: 0.1,
                       minimumValueLabel: Text("-5"),
                       maximumValueLabel: Text("0"),
                       label: { EmptyView() })
            }
            
            VStack(alignment: .leading) {
                Text("Rope length: \(pointsManager.ropeLength)")
                Slider(value: $pointsManager.ropeLength,
                       in: 0...800,
                       step: 1,
                       minimumValueLabel: Text("0"),
                       maximumValueLabel: Text("800"),
                       label: { EmptyView() })
            }
        }
    }
}

// MARK: - Gestures

extension RopeViewWithAnimation {
    var dragGestureForPointP0: some Gesture {
        DragGesture()
            .onChanged{ value in
                pointsManager.pointP0 = CGPoint(
                    x: value.startLocation.x
                    + value.translation.width,
                    y: value.startLocation.y
                    + value.translation.height
                )
            }
            .onEnded{ value in
                pointsManager.pointP0 = CGPoint(
                    x: value.startLocation.x + value.translation.width,
                    y: value.startLocation.y + value.translation.height
                )
            }
    }
    
    var dragGestureForPointP2: some Gesture {
        DragGesture()
            .onChanged{ value in
                pointsManager.pointP2 = CGPoint(
                    x: value.startLocation.x + value.translation.width,
                    y: value.startLocation.y + value.translation.height
                )
            }
            .onEnded{ value in
                pointsManager.pointP2 = CGPoint(
                    x: value.startLocation.x + value.translation.width,
                    y: value.startLocation.y + value.translation.height
                )
            }
    }
}

// MARK: - Previews

struct RopeViewWithAnimation_Previews: PreviewProvider {
    static var previews: some View {
        RopeViewWithAnimation()
    }
}
