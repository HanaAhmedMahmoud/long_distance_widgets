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
                .ignoresSafeArea()
            
            //contain all of images
            VStack {
                // text elements and titles
                HStack(alignment: .top, spacing: 2){
                    Image("moonAndStars")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                    Spacer()
                    Text("11295 miles")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 1, x: 3, y: 3)
                        .offset(y:10)
                    Spacer()
                    Image("NZstars")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .offset(y:5)
                }.padding(.horizontal, 10)
                    
                
                //world and humans
                VStack{
                    ZStack{
                    
                        Image("world")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 320, height: 30)
                            .offset(y:11)
                        Image("lines")
                            .resizable()
                            .scaledToFill()
                            .offset(x:0, y: -8)
                        Image("plane")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .offset(x:0, y: -40)
                            
                        
                        HStack(){
                            Image("man")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            Spacer()
                            Image("woman")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        }.padding(.horizontal,10)
                    }
                }.ignoresSafeArea()
                
            }.padding()
            
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

