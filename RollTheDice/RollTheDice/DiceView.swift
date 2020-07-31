//
//  DiceView.swift
//  RollTheDice
//
//  Created by Cathal Farrell on 31/07/2020.
//  Copyright © 2020 Cathal Farrell. All rights reserved.
//

import SwiftUI

struct DiceView: View {

    var number: Int

    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 100, height:100)
                .cornerRadius(20)
            Text("\(number)")
                .foregroundColor(Color.white)
                .font(.system(size: 60))
        }
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(number: 6)
    }
}
