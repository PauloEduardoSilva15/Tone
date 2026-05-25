//
//  EntryPage.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI

struct EntryPage: View {
    @State private var irMain: Bool = false
    let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    var body: some View {
        NavigationStack{
            ZStack{
                Image("EntryPage")
                    .resizable()
//                    .frame(height: isIpad ?  1300 : 920)
                    .ignoresSafeArea()
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
