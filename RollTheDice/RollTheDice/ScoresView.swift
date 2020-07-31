//
//  ScoresView.swift
//  RollTheDice
//
//  Created by Cathal Farrell on 30/07/2020.
//  Copyright © 2020 Cathal Farrell. All rights reserved.
//

import SwiftUI

struct ScoresView: View {

    @EnvironmentObject var results: Results

    static let scoreDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        NavigationView {
            List {
                ForEach(results.scores, id: \.self) { score in
                    HStack{
                        Text("\(score.timeScored, formatter: Self.scoreDateFormat)")
                        Spacer()
                        Text("\(score.result)")
                    }

                }
            }
            .navigationBarTitle("Scores")
        }
    }
}

struct ScoresView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresView()
    }
}
