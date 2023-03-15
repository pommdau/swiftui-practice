//
//  NSScreen+displayID.swift
//  FullScreenPanelDemo
//
//  Created by HIROKI IKEUCHI on 2023/02/28.
//

import Cocoa

/// refs: https://gist.github.com/briankc/025415e25900750f402235dbf1b74e42
extension NSScreen {
    var displayID: String {
        guard let displayID = deviceDescription[NSDeviceDescriptionKey(rawValue: "NSScreenNumber")] as? CGDirectDisplayID else {
            return UUID().uuidString  // error
        }
        return "\(displayID)"
    }
}
