//
//  ActionSheetView1.swift
//  ViewInspectorDemo
//
//  Created by Hiroki Ikeuchi on 2023/01/19.
//

import SwiftUI

struct ActionSheetView1: View {
    @State var isShowingSheet: Bool = false
    internal let inspection = Inspection<Self>()
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button {
                isShowingSheet.toggle()
            } label: {
                Text("Toggle")
            }

        }
        .onReceive(inspection.notice, perform: { output in
            inspection.visit(self, output)  // For ViewInspector Tests
        })
        .actionSheet2(isPresented: $isShowingSheet) {
            ActionSheet(title: Text("Title"),
                        message: Text("Message"),
                        buttons: [
                            .destructive(Text("Remove")),
                            .default(Text("Cancel"))
                        ])
        }
    }
}

struct ActionSheetView1_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheetView1()
    }
}

// MARK: - ViewInspector

extension View {
    func actionSheet2(isPresented: Binding<Bool>, content: @escaping () -> ActionSheet) -> some View {
        return self.modifier(InspectableActionSheet(isPresented: isPresented, popupBuilder: content))
    }
}

struct InspectableActionSheet: ViewModifier {
    
    let isPresented: Binding<Bool>
    let popupBuilder: () -> ActionSheet
    let onDismiss: (() -> Void)? = nil
    
    func body(content: Self.Content) -> some View {
        content.actionSheet(isPresented: isPresented, content: popupBuilder)
    }
}
