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
/////////////////////////////////////////////////////////
    // CRIA O OBJETO QUE SERÁ OBSERVADO EM TODAS AS TELAS FILHAS
    @StateObject private var key = KeyModel()
////////////////////////////////////////////////////////
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
/////////////////////////////////////////////////////////
        // Passa para as views filhas que o objeto "key" é o ambiente a ser observado
        .environmentObject(key)
/////////////////////////////////////////////////////////
    }
}

#Preview {
    EntryPage()
}
