//
//  AlertView1.swift
//  ViewInspectorDemo
//
//  Created by Hiroki Ikeuchi on 2023/01/19.
//

import SwiftUI

struct AlertView1: View {
    
    @State var isShowingAlert: Bool = false
    internal let inspection = Inspection<Self>()
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button {
                isShowingAlert.toggle()
            } label: {
                Text("Toggle")
            }

        }
        .onReceive(inspection.notice, perform: { output in
            inspection.visit(self, output)  // For ViewInspector Tests
        })
        .alert2(isPresented: $isShowingAlert) {
            Alert(title: Text("Title"),
                  message: Text("Message"),
                  primaryButton: .destructive(Text("Remove")),
                  secondaryButton: .cancel(Text("Cancel"))
            )
        }
    }
}

struct AlertView1_Previews: PreviewProvider {
    static var previews: some View {
        AlertView1()
    }
}

extension View {
    func alert2(isPresented: Binding<Bool>, content: @escaping () -> Alert) -> some View {
        return self.modifier(
            InspectableAlert(isPresented: isPresented, popupBuilder: content)
        )
    }
}

struct InspectableAlert: ViewModifier {
    
    let isPresented: Binding<Bool>
    let popupBuilder: () -> Alert
    let onDismiss: (() -> Void)? = nil
    
    func body(content: Self.Content) -> some View {
        content.alert(isPresented: isPresented, content: popupBuilder)
    }
}

extension View {
    func alert2<Item>(item: Binding<Item?>, content: @escaping (Item) -> Alert) -> some View where Item: Identifiable {
        return self.modifier(InspectableAlertWithItem(item: item, popupBuilder: content))
    }
}

struct InspectableAlertWithItem<Item: Identifiable>: ViewModifier {
    
    let item: Binding<Item?>
    let popupBuilder: (Item) -> Alert
    let onDismiss: (() -> Void)? = nil
    
    func body(content: Self.Content) -> some View {
        content.alert(item: item, content: popupBuilder)
    }
}

