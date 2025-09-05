//  Widgets.swift
//  Widgets
//
//  Created by Hana Mahmoud on 05/09/2025.
//

import WidgetKit
import SwiftUI

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        completion(SimpleEntry(date: Date()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let entry = SimpleEntry(date: Date())
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

struct WidgetsEntryView : View {
    var entry: SimpleEntry

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .clipped()
            VStack {
                Text("11295")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                Text(entry.date, style: .time)
                    .foregroundColor(.white)
            }
            .padding()
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

struct Widgets: Widget {
    let kind: String = "Widgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("Long Distance Widget")
        .description("Even though we're far apart we are close in our hearts")
        .supportedFamilies([.systemMedium])
    }
}

#Preview(as: .systemMedium) {
    Widgets()
} timeline: {
    SimpleEntry(date: .now)
}

