//
//  WidgetsBundle.swift
//  Widgets
//
//  Created by Hana Mahmoud on 05/09/2025.
//

import WidgetKit
import SwiftUI

@main
struct WidgetsBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        DistanceWidget()
        TimerWidget()
    }
}
