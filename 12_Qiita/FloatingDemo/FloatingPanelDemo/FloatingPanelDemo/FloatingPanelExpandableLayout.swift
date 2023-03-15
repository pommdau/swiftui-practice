//
//  FloatingPanelExpandableLayout.swift
//  FloatingPanelDemo
//
//  Created by HIROKI IKEUCHI on 2023/03/06.
//

import SwiftUI
 
/// This SwiftUI view provides basic modular capability to a `FloatingPanel`.
public struct FloatingPanelExpandableLayout<Toolbar: View, Sidebar: View, Content: View>: View {

    @ViewBuilder let toolbar: () -> Toolbar
    @ViewBuilder let sidebar: () -> Sidebar
    @ViewBuilder let content: () -> Content
 
    /// The minimum width of the sidebar
    var sidebarWidth: CGFloat = 256.0
    /// The minimum width for both views to show
    var totalWidth: CGFloat = 512.0
    /// The minimum height
    var minHeight: CGFloat = 512.0
 
    /// Stores the expanded width of the view on toggle
    @State var expandedWidth = 512.0
 
    /// Stores a reference to the parent panel instance
    @Environment(\.floatingPanel) var panel
    
    public var body: some View {
        GeometryReader { geo in
            ZStack {
                VisualEffectView(material: .sidebar)
     
                VStack(spacing: 0) {
                    /// Display toolbar and toggle button
                    toolbarSection(geo: geo)
     
                    /// Add a visual cue to separate the sections
                    Divider()
     
                    /// Display sidebar and content view
                    HStack(spacing: 0) {
                        /// Display the sidebar and center it in a vertical stack to fill in the space
                        VStack {
                            Spacer()
                            /// Set the minimum width to the sidebar width, and the maximum width if expanded to the sidebar width, otherwise set it to the total width
                            sidebar()
                                .frame(minWidth: sidebarWidth, maxWidth: expanded(for: geo.size.width) ? sidebarWidth : totalWidth)
                            Spacer()
                        }
     
                        /// Only show content view if expanded
                        /// Set its frame so it's centered no matter what
                        /// Include the divider in this, since we don't want a divider lying around if there is nothing to divide
                        /// Also attach a move from edge transition
                        if expanded(for: geo.size.width) {
                            HStack(spacing: 0) {
                                Divider()
                                content()
                                    .frame(width: geo.size.width-sidebarWidth)
                            }
                            .transition(.move(edge: .trailing))
                        }
                    }
                    .animation(.spring(), value: expanded(for: geo.size.width))
                }
            }
        }
        .frame(minWidth: sidebarWidth, minHeight: minHeight)
    }
    
    @ViewBuilder
    private func toolbarSection(geo: GeometryProxy) -> some View {
        HStack {
            toolbar()
            Spacer()

            /// Toggle button
            Button(action: toggleExpand) {
                /// Use different SF Symbols to indicate the future state
                Image(systemName: expanded(for: geo.size.width) ?  "menubar.rectangle" : "uiwindow.split.2x1")
            }
            .buttonStyle(.plain)
                .font(.system(size: 18, weight: .light))
                .foregroundStyle(.secondary)
        }
        .padding(16)
    }
    
    /// Toggle the expanded state of the panel
    func toggleExpand() {
        
        guard let panel else { return }
        
        /// Use the parent panel's frame for reference
        let frame = panel.frame
 
        /// If expanded, store the expanded width for later use
        if expanded(for: frame.width) {
            expandedWidth = frame.width
        }
 
        /// If expanded, the new width should be the minimum sidebar width, if not, make it the largest of either the stored expanded width or the total width
        let newWidth = expanded(for: frame.width) ? sidebarWidth : max(expandedWidth, totalWidth)
 
        /// Create a new frame that centers the new width on resize
        let newFrame = CGRect(x: frame.midX-newWidth/2, y: frame.origin.y, width: newWidth, height: frame.height)
 
        /// Resize the parent panel. The view should resize itself as a consequence.
        panel.setFrame(newFrame, display: true, animate: true)
    }
    
    /// Since the expanded state of the view based on its current geometry, let's make a function for it.
    func expanded(for width: CGFloat) -> Bool {
        return width >= totalWidth
    }
}
