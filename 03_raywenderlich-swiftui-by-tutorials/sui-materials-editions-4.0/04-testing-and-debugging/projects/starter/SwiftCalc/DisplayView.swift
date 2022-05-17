import SwiftUI

extension Color {
    
    // Return a random color
    static var random: Color {
        return Color(
             red: .random(in: 0...1),
             green: .random(in: 0...1),
             blue: .random(in: 0...1)
           )
    }
    
}

struct DisplayView: View {
    @Binding var display: String
    
    var body: some View {
        
        /*
         e.g.
         DisplayView: @self, @identity changed.
         DisplayView: _display changed.
         */
//        let _ = Self._printChanges()
        
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
        .background(Color.random)
    }
}

struct DisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView(display: .constant("123"))
    }
}
