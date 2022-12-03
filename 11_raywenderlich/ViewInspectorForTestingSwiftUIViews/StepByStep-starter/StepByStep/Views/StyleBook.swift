import SwiftUI
import UIKit

extension Text {
  func conditionallyItalic(_ isItalic: Bool) -> Text {
    if isItalic {
      return self.italic()
    } else {
      return self
    }
  }
}

struct IdiomaticNavigationStyle: ViewModifier {
  var isPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
  func body(content: Content) -> some View {
    if isPad {
      content.navigationViewStyle(.automatic)
    } else {
      content.navigationViewStyle(.stack)
    }
  }
}

struct AdditiveButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(8)
      .background(Color.green)
      .foregroundColor(.white)
      .clipShape(Capsule())
      .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
      .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
  }
}
