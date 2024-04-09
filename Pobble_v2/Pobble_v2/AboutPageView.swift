//
//  AboutPageView.swift
//  Pobble_v2
//
//  Created by Raleigh Desmond on 2024-03-21.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            Text("About Word Game")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            Text("Raleigh Desmond - 101374701\nHarlan Ferguson 101133838\nOwen Beattie - 101379668\nRichard Wilson - 103370635 ")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding()
        .navigationBarTitle(Text("About"), displayMode: .inline)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
