//
//  EntryPage.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI

struct EntryPage: View {
    @State private var irMain: Bool = false
    var body: some View {
        NavigationStack{
            ZStack{
                Image("EntryPage")
                    .resizable()
                    .frame(height: 920)
                Image("Logo")
                    .padding(.bottom, 30)
            }
            .navigationDestination(isPresented: $irMain) {
                MainPage()
            }
        }
        .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            irMain = true
        }
    }
}    
}

#Preview {
    EntryPage()
}
