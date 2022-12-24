//
//  Robot.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/27.
//

import SwiftUI

struct Robot: View {
    
    static let originalPathSize = CGSize(width: 200, height: 232.48)  // ロボットのsvgサイズ
    @StateObject private var viewModel = TimerViewModel()
    @State private var isPresentingTimerEditView = false
    
    private static func calculateOffsetY(viewHeight: CGFloat, svgHeight: CGFloat) -> CGFloat {
        if viewHeight > svgHeight {
            return (viewHeight / 2) - (svgHeight / 2)
        } else {
            return .zero
        }
    }
    
    private static func calculateScale(geometrySize: CGSize, svgSize: CGSize) -> CGFloat {
        let scale: CGFloat
        if geometrySize.width < geometrySize.height {
            scale = geometrySize.width / svgSize.width
        } else {
            scale = geometrySize.height / svgSize.height
        }
        
        return scale
    }
    
    var body: some View {
        
        ZStack {
            Color.background(state: viewModel.state)
            
            VStack {
                HeadertText()
                    .padding()
                
                GeometryReader { geometry in
                    let length = min(geometry.size.width, geometry.size.height)
                    let scale = Self.calculateScale(geometrySize: geometry.size,
                                                    svgSize: Self.originalPathSize)
                    let center = CGPoint(x: geometry.size.width / 2,
                                         y: geometry.size.height / 2)
                    let standatdOffset = CGSize(width: Self.originalPathSize.width * scale,
                                                height: Self.originalPathSize.height * scale)
                    
                    Button {
                        isPresentingTimerEditView = true
                    } label: {
                        eye()
                    }
                    .frame(width: length * 0.18)
                    .position(center)
                    .offset(x: -standatdOffset.width * 0.18,
                            y: -standatdOffset.height * 0.25)
                                        
                    eye()
                        .frame(width: length * 0.18)
                        .position(center)
                        .offset(x: standatdOffset.width * 0.18,
                                y: -standatdOffset.height * 0.25)
                    
                    timerText()
                        .frame(width: length * 0.58)
                        .position(center)
                        .offset(x: 0,
                                y: -standatdOffset.height * 0.09)
                                        
                    robotBodyText(viewWidth: length * 1.0,
                                  offset: standatdOffset,
                                  tappedAction: viewModel.rightEyeClicked)
                    
                    Path.robot()
                        .fill(Color.body(state: viewModel.state))
                        .offset(x: (geometry.size.width - Self.originalPathSize.width) / 2,
                                y: (geometry.size.height - Self.originalPathSize.height) / 2)
                        .scaleEffect(scale)
                        .zIndex(-1)
                }
                .padding(.horizontal)
                
                FooterText()
                    .padding()
            }
        }
        .ignoresSafeArea(edges: [.bottom, .leading, .trailing])

        .sheet(isPresented: $isPresentingTimerEditView) {
            timerEditView()
        }
    }
}

// MARK: - @ViewBuilder

extension Robot {
    
    @ViewBuilder
    private func timerEditView() -> some View {
        NavigationView {
            TimerEditView(time: $viewModel.remainTimeBuffer)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isPresentingTimerEditView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            isPresentingTimerEditView = false
                            viewModel.remainTime = viewModel.remainTimeBuffer
                        }
                    }
                }
        }
    }
    
    @ViewBuilder
    private func HeadertText() -> some View {
        let text = "PUNISHMENT"
        
        switch viewModel.state {
        case .inReady, .inProgress:
            Text(text)
                .lineLimit(1)
                .font(.system(size: 100))
                .minimumScaleFactor(0.01)
                .foregroundColor(.white)
        case .isTimerOver:
            Text(text)
                .lineLimit(1)
                .font(.system(size: 100))
                .minimumScaleFactor(0.01)
                .foregroundColor(.black)
        }
    }
    
    @ViewBuilder
    private func FooterText() -> some View {
        let text = "EXPLOSION!!!"
    
        switch viewModel.state {
        case .inReady, .inProgress:
            Text(text)
                .lineLimit(1)
                .font(.system(size: 100))
                .fontWeight(.regular)
                .minimumScaleFactor(0.01)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
        case .isTimerOver:
            Text(text)
                .lineLimit(1)
                .font(.system(size: 100))
                .minimumScaleFactor(0.01)
                .foregroundColor(.black)
        }
    }
    
    @ViewBuilder
    private func eye() -> some View {
        Circle()
            .foregroundColor(.eye(state: viewModel.state))
    }
    
    @ViewBuilder
    private func timerText() -> some View {        
        switch viewModel.state {
        case .inReady, .inProgress:
            Text(viewModel.timerText)
                .lineLimit(1)
                .font(.system(size: 100, weight: .light).monospacedDigit())
                .minimumScaleFactor(0.01)
                .foregroundColor(.white)
        case .isTimerOver:
            Text(viewModel.timerText)
                .lineLimit(1)
                .font(.system(size: 100, weight: .light).monospacedDigit())
                .minimumScaleFactor(0.01)
                .foregroundColor(.black)
        }
    }
    
    @ViewBuilder
    private func robotBodyText(viewWidth width: CGFloat,
                               offset: CGSize,
                               tappedAction: @escaping () -> ()) -> some View {
        
        switch viewModel.state {
        case .inReady:
            Button {
                tappedAction()
            } label: {
                Text("Touch to start")
                    .lineLimit(1)
                    .font(.system(size: 100))
                    .fontWeight(.light)
                    .minimumScaleFactor(0.01)
                    .foregroundColor(.white)
            }
            .frame(width: width * 0.48)
            .offset(.init(width: offset.width * 0.26,
                          height: offset.height * 0.82))
        case .inProgress:
            Button {
                tappedAction()
            } label: {
                Text("PLEASE ENJOY\nTHE PARTY!")
                    .mainLabel(lineLimit: 2, color: .white)
            }
            .frame(width: width * 0.52)
            .offset(.init(width: offset.width * 0.24,
                          height: offset.height * 0.78))
        case .isTimerOver:
            Button {
                tappedAction()
            } label: {
                Text("TIME UP!")
                    .lineLimit(1)
                    .font(.system(size: 100))
                    .fontWeight(.light)
                    .minimumScaleFactor(0.01)
                    .foregroundColor(.red)
            }
            .frame(width: width * 0.30)
            .offset(.init(width: offset.width * 0.35,
                          height: offset.height * 0.82))
        }
    }
}

extension CGPoint {
    
    func convert(scale: CGFloat = 1.0, offset: CGSize = .zero) -> CGPoint {
        return CGPoint(x: self.x * scale + offset.width,
                       y: self.y * scale + offset.height)
    }
}

extension Robot {
    
    func createDebugPath() -> Path {
        return Path { path in
            path.move(to: .init(x: 0, y: 0))
            path.addLine(to: .init(x: 0, y: 100))
            path.addLine(to: .init(x: 100, y: 100))
            path.addLine(to: .init(x: 100, y: 0))
            path.addLine(to: .init(x: 0, y: 0))
        }
    }
}

struct Robot_Previews: PreviewProvider {
    static var previews: some View {
        Robot()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
        
        Robot()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
    }
}
