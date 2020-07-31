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

    @State private var sidesIndex = 1
    let sidesOfDice = [4, 6, 8, 12, 100]

    @State private var currentScore = 0
    @State private var timeRemaining = 5
    @State private var timer = Timer.publish (every: 1, on: .current, in: .common).autoconnect()
    @State private var number1: Int = Int.random(in: 1..<7)
    @State private var number2: Int = Int.random(in: 1..<7)
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer(minLength: 50)
                VStack {
                    HStack {
                        Text("Choose the number of sides:")
                        Spacer()
                    }

                    Picker("Number of sides", selection: $sidesIndex) {
                        ForEach(0 ..< sidesOfDice.count) {
                            Text("\(self.sidesOfDice[$0])")
                        }

                    }
                    .background(Color.green)
                    .cornerRadius(10)
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(30)

                HStack {
                    DiceView(number: number1)
                    DiceView(number: number2)
                }
                .padding(50)

                VStack {

                    if currentScore > 0 {
                        Text("✨ You have rolled: \(currentScore) ✨")
                            .font(.title)
                    } else {
                        Text("Best of luck!")
                            .font(.title)
                    }

                    Spacer()

                    Button("Roll Dice") {
                        self.rollTheDice()
                        self.startTimer()
                    }
                    .frame(width: 200, height: 50)
                    .background(Color.green)
                    .foregroundColor(Color.white)

                    .clipShape(Capsule())
                    .padding(100)
                }
            }
            .navigationBarTitle("Roll The Dice", displayMode: .inline)

        }
        .onReceive(timer) { time in
            print("Time remaining: \(self.timeRemaining)")
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1

                self.rollTheDice()

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

    fileprivate func rollTheDice() {
        self.currentScore = 0
        self.number1 = self.getRandomNumber()
        self.number2 = self.getRandomNumber()
    }

    fileprivate func getRandomNumber() -> Int {
        switch sidesOfDice[sidesIndex] {
        case 4:
            return Int.random(in: 1..<5)
        case 8:
            return Int.random(in: 1..<9)
        case 12:
            return Int.random(in: 1..<13)
        case 100:
            return Int.random(in: 1..<101)
        default:
            //Normal 6-sided dice
            return Int.random(in: 1..<7)
        }
    }

    fileprivate func handleGameOver() {
        // Handle Game Over

        if self.timeRemaining == 0 {
            print("🛑 Times up")
            self.timer.upstream.connect().cancel()

            //Store score
            currentScore = self.number1 + self.number2
            let myScore = Score(result: currentScore)
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
