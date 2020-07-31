//
//  RollView.swift
//  RollTheDice
//
//  Created by Cathal Farrell on 30/07/2020.
//  Copyright © 2020 Cathal Farrell. All rights reserved.
//

import SwiftUI

struct RollView: View {

    @EnvironmentObject var results: Results
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Hello, Roll!")

                Button("Roll") {
                    let myScore = Score(result: 999)
                    self.results.scores.append(myScore)
                }
            }
            .navigationBarTitle("Roll The Dice")

        }
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
