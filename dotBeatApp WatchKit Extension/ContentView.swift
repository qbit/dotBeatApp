//
//  ContentView.swift
//  dotBeatApp WatchKit Extension
//
//  Created by Aaron Bieber on 7/31/19.
//  Copyright © 2019 Aaron Bieber. All rights reserved.
//

import SwiftUI
import Beat

struct ContentView: View {
    @State var bt = Beat().text()
    var body: some View {
        VStack {
            Text("It's currently:")
            Text("@\(self.bt)")
                .font(.largeTitle)
                .onAppear {
                    NSLog("appear")
                    self.bt = Beat().text()
                }
                .onTapGesture {
                    NSLog("tap")
                    self.bt = Beat().text()
                }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
