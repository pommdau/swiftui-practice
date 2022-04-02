import SwiftUI

struct NewButtonStyle: ButtonStyle {
    let width: CGFloat
    let height: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.2 : 1)
            .frame(width: width, height: height)
            .background(
                Group {
                  if configuration.isPressed {
                    Capsule()
                      .fill(Color.element)
                  } else {
                    Capsule()
                      .fill(Color.element)
                      .northWestShadow()
                  }
                }
            )
    }

}
