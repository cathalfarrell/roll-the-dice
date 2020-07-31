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

    @State private var timeRemaining = 5
    @State private var timer = Timer.publish (every: 1, on: .current, in: .common).autoconnect()
    @State private var diceNumber1: Int = Int.random(in: 1..<7)
    @State private var diceNumber2: Int = Int.random(in: 1..<7)
    
    var body: some View {
        NavigationView {
            ZStack{
                HStack {
                    Image(systemName: "\(diceNumber1).square.fill").resizable()
                        .frame(width: 100.0, height: 100.0)
                    Image(systemName: "\(diceNumber2).square.fill").resizable()
                        .frame(width: 100.0, height: 100.0)
                }
                VStack {
                    Spacer()
                    Button("Roll") {
                        self.diceNumber1 = Int.random(in: 1..<7)
                        self.diceNumber2 = Int.random(in: 1..<7)
                        self.startTimer()
                    }
                    .frame(width: 100, height: 50)
                    .background(Color.green)
                    .foregroundColor(Color.white)

                    .clipShape(Capsule())
                    .padding(100)
                }

            }
            .navigationBarTitle("Roll The Dice")

        }
        .onReceive(timer) { time in
            print("Time remaining: \(self.timeRemaining)")
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1

                self.diceNumber1 = Int.random(in: 1..<7)
                self.diceNumber2 = Int.random(in: 1..<7)

                self.handleGameOver()
            }
        }
        .onAppear() {
            print("Cancel Timer")
            self.timer.upstream.connect().cancel()
        }
        .onDisappear() {
            print("Cancel Timer")
            self.timer.upstream.connect().cancel()
        }
    }

    fileprivate func handleGameOver() {
        // Handle Game Over

        if self.timeRemaining == 0 {
            print("🛑 Times up")
            self.timer.upstream.connect().cancel()

            //Store score
            let myScore = Score(result: self.diceNumber1 + self.diceNumber2)
            self.results.scores.append(myScore)
        }
    }

    fileprivate func startTimer() {
        self.timer = Timer.publish (every: 1, on: .current, in:
        .common).autoconnect()
        timeRemaining = 5
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
