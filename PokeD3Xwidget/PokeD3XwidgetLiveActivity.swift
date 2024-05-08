//
//  PokeD3XwidgetLiveActivity.swift
//  PokeD3Xwidget
//
//  Created by Joshua Arnold on 5/7/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct PokeD3XwidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct PokeD3XwidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PokeD3XwidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension PokeD3XwidgetAttributes {
    fileprivate static var preview: PokeD3XwidgetAttributes {
        PokeD3XwidgetAttributes(name: "World")
    }
}

extension PokeD3XwidgetAttributes.ContentState {
    fileprivate static var smiley: PokeD3XwidgetAttributes.ContentState {
        PokeD3XwidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: PokeD3XwidgetAttributes.ContentState {
         PokeD3XwidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: PokeD3XwidgetAttributes.preview) {
   PokeD3XwidgetLiveActivity()
} contentStates: {
    PokeD3XwidgetAttributes.ContentState.smiley
    PokeD3XwidgetAttributes.ContentState.starEyes
}
