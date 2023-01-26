//
//  Inspection+Model.swift
//  GuidePopupTests
//
//  Created by Hiroki Ikeuchi on 2023/01/19.
//

import Foundation
import ViewInspector
@testable import ViewInspectorDemo

extension Inspection: InspectionEmissary { }
extension InspectableAlert: PopupPresenter { }
extension InspectableActionSheet: PopupPresenter { }
