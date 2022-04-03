import SwiftUI

struct DisplayView: View {
    @Binding var display: String
    
    var body: some View {
        HStack {
            if display.isEmpty {
                Text("0")
                    .accessibility(identifier: "display")
                    .padding(.horizontal, 5)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .trailing
                    )
                    .overlay(
                        RoundedRectangle(
                            cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .foregroundColor(Color.gray)
                    )
            } else {
                Text(display)
                    .accessibility(identifier: "display")
                    .padding(.horizontal, 5)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .trailing
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 2)
                            .foregroundColor(Color.gray)
                    )
            }
        }
    }
}

struct DisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView(display: .constant("123"))
    }
}
