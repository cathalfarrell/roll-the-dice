//
//  ContentView.swift
//  RollTheDice
//
//  Created by Cathal Farrell on 28/07/2020.
//  Copyright © 2020 Cathal Farrell. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Text("Roll The Dice")
                .tabItem {
                    Image(systemName: "circle.grid.hex")
                    Text("Roll The Dice")
                }
            Text("Show the scores")
                .tabItem {
                    Image(systemName: "star.circle.fill")
                    Text("Scores")
                }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
