import SwiftUI

struct HorizontallyAlignedLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {        
        HStack {
            configuration.icon
            configuration.title
        }
    }
}
