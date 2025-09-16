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

// ENTRY for widgets
//date are mandatory attributes of struct
struct DistanceEntry: TimelineEntry {
    var date: Date
    let miles: Int
    let angle: Double
}

struct TimerEntry: TimelineEntry {
    let date: Date
    let remaining: TimeInterval
}


// PROVIDER for widgets
// follows TimelineProvider (see above)
// PHILLIP PLEASE DO THIS (your time to shine)
struct DistanceProvider: TimelineProvider {
    func placeholder(in context: Context) -> DistanceEntry {
        DistanceEntry(date: Date(), miles: 11295, angle: 0)
    }

    func getSnapshot(in context: Context, completion: @escaping (DistanceEntry) -> ()) {
        completion(DistanceEntry(date: Date(), miles: 11295, angle: 0))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<DistanceEntry>) -> ()) {
        var entries: [DistanceEntry] = []
        let now = Date()

        //plane animation
        for second in 0..<60 {
            let angle = Double(second) / 60 * 2 * .pi
            let entry = DistanceEntry(date: now.addingTimeInterval(Double(second)),
                                      miles: 11295,
                                      angle: angle)
            entries.append(entry)
        }

        completion(Timeline(entries: entries, policy: .atEnd))
    }
}


struct TimerProvider: TimelineProvider {
    func placeholder(in context: Context) -> TimerEntry {
        TimerEntry(date: Date(), remaining: 3600)
    }

    func getSnapshot(in context: Context, completion: @escaping (TimerEntry) -> ()) {
        completion(TimerEntry(date: Date(), remaining: 3600))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<TimerEntry>) -> ()) {
        let now = Date()
        let end = now.addingTimeInterval(3600)
        
        var entries: [TimerEntry] = []
        for offset in stride(from: 0, to: 3600, by: 60) {
            let entryDate = now.addingTimeInterval(Double(offset))
            let remaining = end.timeIntervalSince(entryDate)
            entries.append(TimerEntry(date: entryDate, remaining: max(remaining, 0)))
        }
        
        completion(Timeline(entries: entries, policy: .atEnd))
    }
}



// VIEWS for widgets
// basically the interface for widgets
// Hana's time to shine :)

struct DistanceWidgetsEntryView : View {
    var entry: DistanceEntry

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
                        
                        //plane animation
                        GeometryReader { geo in
                                let leftX: CGFloat = 60
                                let rightX: CGFloat = geo.size.width - 60
                                let centerY: CGFloat = geo.size.height / 2 - 20
                                                
                                // progress goes 0 → 1 → 0 over time
                                let progress = abs(sin(entry.angle))
                                let goingRight = cos(entry.angle) >= 0
                                let xPos = leftX + (rightX - leftX) * progress
                                                
                                Image("plane")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .position(x: xPos, y: centerY)
                                    .rotationEffect(.degrees(goingRight ? 0 : 180))
                        }.frame(height: 50)
                                            
                                            
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

struct TimerWidgetEntryView : View {
    var entry: TimerEntry
    var body: some View {
        ZStack {
            Image("background2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            VStack(spacing: 8){
                HStack(alignment: .top, spacing: 30){
                    Image("moonAndStars")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                    Text("Together")
                        .font(.custom("LeckerliOne-Regular", size: 37))
                        .bold()
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 1, x: 3, y: 3)
                        .offset(y:5)
                    Image("NZstars")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .offset(y:5)
                }.padding(.horizontal, 15)
                 .padding(.top, 4)
                 .padding(.bottom, 2)
    
                VStack(spacing: 8){
                    HStack(spacing: 4) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .frame(width: 50, height: 50)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 2))
                            Text("00")
                                .font(.custom("DigitalNumbers-Regular", size: 25))
                        }
                        
                        Image("hearts")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10, height: 30)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .frame(width: 50, height: 50)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 2))
                            Text("00")
                                .font(.custom("DigitalNumbers-Regular", size: 25))
                        }
                        
                        Image("hearts")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10, height: 30)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .frame(width: 50, height: 50)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 2))
                            Text("00")
                                .font(.custom("DigitalNumbers-Regular", size: 25))
                        }
                        
                        Image("hearts")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10, height: 30)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .frame(width: 50, height: 50)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 2))
                            Text("00")
                                .font(.custom("DigitalNumbers-Regular", size: 25))
                        }
                        
                        Image("hearts")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10, height: 30)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .frame(width: 50, height: 50)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 2))
                            Text("00")
                                .font(.custom("DigitalNumbers-Regular", size: 25))
                            
                        }
                    }.padding(.horizontal, 10)
                    
                    HStack(spacing:10) {
                        Text("MONTHS")
                        Text("DAYS")
                        Text("HOURS")
                        Text("MINUTES")
                        Text("SECONDS")
                    }.font(.custom("Tiny5-Regular", size: 16))
                     .frame(maxWidth: .infinity, alignment: .center)
                    
                }
                
            }
            
        }.containerBackground(Color.clear, for: .widget)
         .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
    
    // WIDGET DEFINITIONS
    // glues the views and providers
    struct DistanceWidget: Widget {
        let kind: String = "Distance Widgets"
        
        var body: some WidgetConfiguration {
            StaticConfiguration(kind: kind, provider: DistanceProvider()) { entry in
                DistanceWidgetsEntryView(entry: entry)
            }
            .configurationDisplayName("Long Distance Widget")
            .description("Even though we're far apart we are close in our hearts")
            .supportedFamilies([.systemMedium])
        }
    }
    
    struct TimerWidget:Widget {
        let kind: String = "Timer Widget"
        
        var body: some WidgetConfiguration {
            StaticConfiguration(kind: kind, provider: TimerProvider()) { entry in
                TimerWidgetEntryView(entry: entry)
            }
            .configurationDisplayName("Long Distance Timer Widget")
            .description("A counter for how long we have been together")
            .supportedFamilies([.systemMedium])
        }
    }
    
    
    // PREVIEWS (chose either, what you want to view in the preview on side)
    
    //#Preview(as: .systemMedium) {
     //   DistanceWidget()
    //} timeline: {
      //  DistanceEntry(date: .now, miles: 11295, angle: 0 )
    //}
    
    #Preview(as: .systemMedium) {
        TimerWidget()
    } timeline: {
        TimerEntry(date: .now, remaining: 100000)
    }
    
