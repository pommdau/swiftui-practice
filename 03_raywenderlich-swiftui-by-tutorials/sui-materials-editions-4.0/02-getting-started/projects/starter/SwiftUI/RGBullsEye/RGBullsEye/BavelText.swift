import SwiftUI

struct BavelText: View {
    
    let text: String
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Text(text)
            .frame(width: width, height: height)
            .background(
                ZStack {
                    Capsule()
                        .fill(Color.element)
                        .northWestShadow(radius: 3, offset: 1)
                    Capsule()
                        .inset(by: 3)
                        .fill(Color.element)
                        .southEastShadow(radius: 1, offset: 1)
                }
            )
    }
}

struct BavelText_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.element
            BavelText(text: "R: ??? G: ??? B: ???", width: 200, height: 48)
        }
        .frame(width: 300, height: 100)
        .previewLayout(.sizeThatFits)
    }
}
