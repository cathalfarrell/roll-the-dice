//
//  ContentView.swift
//  RollTheDice
//
//  Created by Cathal Farrell on 28/07/2020.
//  Copyright © 2020 Cathal Farrell. All rights reserved.
//

import SwiftUI

struct Score: Hashable {
    let id = UUID()
    var timeScored = Date()
    var result: Int
}

class Results: ObservableObject {
    @Published var scores: [Score]

    init() {
        self.scores = [Score]()
    }
}

struct ContentView: View {

    var results = Results()

    var body: some View {
        TabView {
            RollView()
                .tabItem {
                    Image(systemName: "circle.grid.hex")
                    Text("Roll The Dice")
                }
            ScoresView()
                .tabItem {
                    Image(systemName: "star.circle.fill")
                    Text("Scores")
                }
        }
        .environmentObject(results)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
