//
//  HorizontalMain.swift
//  Tone
//
//  Created by Gabriel Groppo on 25/05/26.
//

import SwiftUI

struct HorizontalMain: View {
    @State private var showAcordes: Bool = false
    let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    
    // 1. Criamos a variável do ViewModel para gerenciar esta tela
    @State private var viewModel = CarouselViewModel()
    
    var body: some View {
        ZStack{
            Image("BackGroundImage")
                .resizable()
                .ignoresSafeArea()
            
            // AnimatedStarsOverlay() // Descomente se tiver no seu projeto
            
            HStack{
                VStack(alignment: .leading){
                    Image(isIpad ? "MediumLogo" : "SmallLogo")
                        .padding(.trailing )
                        
                    Spacer()
                    VStack{
                        Text("Escolha o tom")
                            .foregroundStyle(Color("ColorSecondary"))
                            .font(isIpad ? .title : .title2)
                            .fontWeight(isIpad ? .bold : .semibold)
                        
                        ChoiceKeyCarroussel()
                            .padding(.top, 20)
                            .padding(.bottom, 20)
                        
                        Text("Escolha a escala")
                            .foregroundStyle(Color("ColorSecondary"))
                            .font(isIpad ? .title : .title2)
                            .fontWeight(isIpad ? .bold : .semibold)
                            .padding(.bottom, 30)
                        
                        ScaleChoice()
                            .padding(.bottom, 40)
                        
                        
                        Text("Quer expressar algo?")
                            .foregroundStyle(Color("ColorSecondary"))
                            .font(isIpad ? .title : .title2)
                            .fontWeight(isIpad ? .bold : .semibold)
                            .padding(.bottom, 20)
                        
                        HStack{
                            EmotionDropdown()
                                .padding(.vertical, 10)
                            Spacer()
                            // PlayButton(corEmocao: Color("ColorPrimary")) // Descomente se tiver
                        }
                        .padding(.bottom, 120)
                        
                    }
                    .frame(width: 450)
                    .padding(.horizontal, 70)
                    Spacer()
                }
                VStack{
                    Spacer()
                    Text("Campo Harmônico")
                        .foregroundStyle(Color("ColorSecondary"))
                        .font(isIpad ? .title : .title2)
                        .fontWeight(isIpad ? .bold : .semibold)
                    
                    // 2. Passamos o viewModel para o seu Campo Harmônico
                    ViewHarmonyCamp(viewModel: viewModel)
                        .padding(.top, 8)
                        .padding(.bottom, 10)
                    
                    Button(action:{
                        showAcordes = true
                    }) {
                        Text("Ver Acordes")
                            .font(isIpad ? .title : .body)
                            .foregroundStyle(Color.white)
                            .frame(width: isIpad ? 230: 150, height: isIpad ? 50 : 50)
                            .background(Color("ColorPrimary"))
                            .cornerRadius(40)
                        
                    }
                    .navigationDestination(isPresented: $showAcordes){
                        // ChordsPage() // Descomente se tiver
                    }
                    .padding(.bottom, isIpad ? 70 : 60)
                    Spacer()
                }
                .frame(width: 300)
                .padding(.horizontal, 100)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, isIpad ? 40 : 60)
        }
        // 3. Injetamos no ambiente para que os outros componentes consigam acessar os dados
        .environment(viewModel)
    }
}

#Preview {
    HorizontalMain()
}
