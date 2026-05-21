//
//  ChordCell.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI

struct ChordCell: View {
    
    let notes:[String]
    @Environment(\.horizontalSizeClass) var sizeClass
    var body: some View {
        VStack(alignment: .center) {
            Text(notes.joined(separator: ", "))
        }.frame(width: sizeClass == .regular ? 400 : 300,
                height: sizeClass == .regular ? 100 : 80,)
            .border(.colorSecondary, width:1)
            .cornerRadius(sizeClass == .regular ? 15 : 12)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.white, lineWidth: 1))
           
    }
}


#Preview {
    ChordCell(notes: ["C", "G", "Am"])
}
