//
//  ContentView.swift
//  dotBeatApp
//
//  Created by Aaron Bieber on 7/31/19.
//  Copyright © 2019 Aaron Bieber. All rights reserved.
//

import SwiftUI
import Beat

struct ContentView: View {
    @State var beat = Beat().text()
        
    var body: some View {
        VStack {
            VStack() {
                Text("It's currently:")
                Text("@\(self.beat)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .onTapGesture {
                        self.beat = Beat().text()
                    }
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
