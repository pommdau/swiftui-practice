//
//  ContentView.swift
//  FloatingPanelDemo
//
//  Created by HIROKI IKEUCHI on 2023/03/06.
//
//  refs: [Make a floating panel in SwiftUI for macOS](https://cindori.com/developer/floating-panel)

import SwiftUI

struct ContentView: View {
    @State var showingPanel = false
    @State var showingPanel_VisualEffectView = false
    @State var showingPanel_FloatingPanelExpandableLayout = false
    
    var body: some View {
        
        VStack {
            Button("Present panel 1") {
                showingPanel.toggle()
            }.floatingPanel(isPresented: $showingPanel, content: {
                ZStack {
                    Rectangle()
                        .fill(.white)
                    Text("I'm a floating panel. Click anywhere to dismiss me.")
                }
            })
            
            Button("Present panel ViewalEffectView") {
                showingPanel_VisualEffectView.toggle()
                   }.floatingPanel(isPresented: $showingPanel_VisualEffectView, content: {
                       VisualEffectView(material: .sidebar, blendingMode: .behindWindow)
                   })
            
            Button("Present panel") {
                showingPanel_FloatingPanelExpandableLayout.toggle()
            }.floatingPanel(isPresented: $showingPanel_FloatingPanelExpandableLayout, content: {
                FloatingPanelExpandableLayout(toolbar: {
                    Text("Toolbar")
                }, sidebar: {
                    Text("Sidebar")
                }, content: {
                    Text("Content")
                })
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
