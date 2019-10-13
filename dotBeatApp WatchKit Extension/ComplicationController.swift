//
//  ComplicationController.swift
//  dotBeatApp WatchKit Extension
//
//  Created by Aaron Bieber on 7/31/19.
//  Copyright © 2019 Aaron Bieber. All rights reserved.
//

import ClockKit
import Beat
import WatchKit

class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    let startDate = Date()
    let interval = 60.00*60.00
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler(.forward)
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(startDate)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        let endDate = Date(timeInterval: interval, since: startDate)
        handler(endDate)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        let b = Beat()
        let f = Float(b.int()) * 0.001
        
        let tp = CLKSimpleTextProvider(text: "@\(b.text())", shortText: "\(b.text())")
        
        NSLog("getCurrentTimelineEntry: \(Date())")
        
        if complication.family == .circularSmall {
            let template = CLKComplicationTemplateCircularSmallRingText()
            template.textProvider = tp
            template.fillFraction = f
            template.ringStyle = CLKComplicationRingStyle.open
            let timelineEntry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler(timelineEntry)
        } else if complication.family == .modularSmall {
            let template = CLKComplicationTemplateModularSmallRingText()
            template.textProvider = tp
            template.fillFraction = f
            template.ringStyle = CLKComplicationRingStyle.open
            let timelineEntry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler(timelineEntry)
        } else {
            handler(nil)
        }
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        NSLog("getTimelineEntries:before")
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        NSLog("getTimelineEntries:after")
        var entries: [CLKComplicationTimelineEntry] = []
        var currentDate = date
        
        var nb = Beat(date.timeIntervalSince1970)
        var f = Float(nb.int()) * 0.001
        while (entries.count < limit) {
            //NSLog("\(nb.text()) @ \(currentDate.timeIntervalSince1970) - \(currentDate)")
            let tp = CLKSimpleTextProvider(text: "@\(nb.text())", shortText: "\(nb.text())")
            if complication.family == .circularSmall {
                let template = CLKComplicationTemplateCircularSmallRingText()
                template.textProvider = tp
                template.fillFraction = f
                template.ringStyle = CLKComplicationRingStyle.open
                entries.append(CLKComplicationTimelineEntry(date: currentDate, complicationTemplate: template))
            } else if complication.family == .modularSmall {
                let template = CLKComplicationTemplateModularSmallRingText()
                template.textProvider = tp
                template.fillFraction = f
                template.ringStyle = CLKComplicationRingStyle.open
                entries.append(CLKComplicationTimelineEntry(date: currentDate, complicationTemplate: template))
            }
            
            currentDate = Date(timeInterval: 86.4, since: currentDate)
            nb = Beat(currentDate.timeIntervalSince1970)
            f = Float(nb.int()) * 0.001
        }
        
        if entries.count == limit - 1 {
            
        }
        
        handler(entries)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        NSLog("getLocalizableSampleTemplate")
        let nb = Beat()
        let f = Float(nb.int()) * 0.001
        
        let tp = CLKSimpleTextProvider(text: "@\(nb.text())", shortText: "\(nb.text())")
        if complication.family == .circularSmall {
                let template = CLKComplicationTemplateCircularSmallRingText()
                template.textProvider = tp
                template.fillFraction = f
                template.ringStyle = CLKComplicationRingStyle.open
                handler(template)
        } else if complication.family == .modularSmall {
                let template = CLKComplicationTemplateModularSmallRingText()
                template.textProvider = tp
                template.fillFraction = f
                template.ringStyle = CLKComplicationRingStyle.open
                handler(template)
        }
    }
}
