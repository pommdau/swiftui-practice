import SwiftUI

struct MemoryView: View {
    @Binding var memory: Double
    var geometry: GeometryProxy
    
    var body: some View {
#if targetEnvironment(macCatalyst)
        let doubleTap = TapGesture(count: 2)
            .onEnded { _ in
                self.memory = 0.0
            }
#else
        let memorySwipe = DragGesture(minimumDistance: 20)
            .onEnded { _ in
                self.memory = 0.0
            }
#endif
        
        HStack {
            Spacer()
#if targetEnvironment(macCatalyst)
            Text("\(memory)")
                .accessibility(identifier: "memoryDisplay")
                .padding(.horizontal, 5)
                .frame(
                    width: geometry.size.width * 0.85,
                    alignment: .trailing
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .foregroundColor(Color.gray)
                )
            // Add gesture here
                .gesture(doubleTap)
#else
            Text("\(memory)")
                .accessibility(identifier: "memoryDisplay")
                .padding(.horizontal, 5)
                .frame(
                    width: geometry.size.width * 0.85,
                    alignment: .trailing
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .foregroundColor(Color.gray)
                )
            // Add gesture here
                .gesture(memorySwipe)
#endif
            Text("M")
        }.padding(.bottom).padding(.horizontal, 5)
    }
}
