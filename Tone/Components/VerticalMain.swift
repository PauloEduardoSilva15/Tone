//  VerticalMain.swift
//  Tone
//
//  Created by Gabriel Groppo on 25/05/26.
//


import SwiftUI

struct VerticalMain: View {
    @State private var acordeAtivo: String? = nil
    @State private var showAcordes: Bool = false
    let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    @Environment(CarouselViewModel.self) var viewModel
    @State private var audioPiano: AdvancedAudioManager = AdvancedAudioManager(filepath: "Audios/C_Piano")
    @State private var progressionTask: Task<Void, Never>? = nil
    
    var body: some View {
        ZStack{
            Image("BackGroundImage")
                .resizable()
                .frame(height: .infinity)
                .ignoresSafeArea()
            
            AnimatedStarsOverlay()
            
            VStack{
                VStack{
                    Image(isIpad ? "MediumLogo" : "SmallLogo")
                        .padding(.trailing, isIpad ? 580 : 280)
                        .padding(.top, isIpad ? 150 : 60)
                    Spacer()
                    
                    Text("Escolha o tom")
                        .foregroundStyle(Color("ColorSecondary"))
                        .font(isIpad ? .title : .title3)
                        .fontWeight(isIpad ? .bold : .semibold)
                    ChoiceKeyCarroussel()
                        .padding(.vertical, 8)
                    //Spacer()
                    
                    Text("Escolha a escala")
                        .foregroundStyle(Color("ColorSecondary"))
                        .font(isIpad ? .title : .title3)
                        .fontWeight(isIpad ? .bold : .semibold)
                        .padding(.bottom, isIpad ? 20 : 8)
                    
                    ScaleChoice()
                        .padding(.bottom, isIpad ? 20 : 8)
                    
                    
                    Text("Quer expressar algo?")
                        .foregroundStyle(Color("ColorSecondary"))
                        .font(isIpad ? .title : .title3)
                        .fontWeight(isIpad ? .bold : .semibold)
                        .padding(.bottom, 8)
                    
                    HStack{
                        EmotionDropdown()
                            .padding(.vertical, 8)
                        
                        
                        Spacer()
                        PlayButton(){
                            PlayProgression()
                        }
                    }
                    
                    .padding(.bottom, 8)
                }
                .zIndex(2)
                Spacer()
                VStack{
                    
                    Text("Campo Harmônico")
                        .foregroundStyle(Color("ColorSecondary"))
                        .font(isIpad ? .title : .headline)
                        .fontWeight(isIpad ? .bold : .semibold)
                    ViewHarmonyCamp(acordeAtivo: acordeAtivo)
                        .padding(.top, 10)
                        .padding(.bottom, 8)
                        .zIndex(0)
                    
                    
                    Button(action:{
                        showAcordes = true
                    }) {
                        Text("Ver Acordes")
                            .font(isIpad ? .title2 : .subheadline)
                            .foregroundStyle(Color.white)
                            .frame(width: isIpad ? 200: 140, height: isIpad ? 50 : 42)
                            .background(Color("ColorPrimary"))
                            .cornerRadius(40)
                        
                    }
                    .navigationDestination(isPresented: $showAcordes){
                        ChordsPage()
                        //.environment(viewModel)
                    }
                    .padding(.bottom, isIpad ? 220 : 120)
                    Spacer()
                }
                .zIndex(0)
            }
            .frame(maxWidth: isIpad ? 450 : 320)
            .padding(.top, isIpad ? 100 : 60)
        }
        .onDisappear {
            StopAudio()
        }
    }
    
    private func PlayProgression() {
        if progressionTask != nil {
            StopAudio()
        }

        let escalaAtual = viewModel.escalaSelecionada
        let emocaoAtual = viewModel.sentimentoSelecionado
        let campoHarmonico = viewModel.campoHarmonicoAtual

        guard emocaoAtual != .nenhum, !campoHarmonico.isEmpty else { return }
        guard let grausDaProgressao = MusicConstants.progressao[escalaAtual]?[emocaoAtual] else { return }

        let acordesParaTocar = grausDaProgressao.compactMap { grauRomano -> String? in
            let alvo = grauRomano.uppercased()
            return campoHarmonico.first(where: { $0.grau.uppercased() == alvo })?.nome
        }

        progressionTask = Task {
            for nomeDoAcorde in acordesParaTocar {
                if Task.isCancelled { break }
                
                await MainActor.run {
                    // Atualiza o acorde ativo com animação fluida
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                        self.acordeAtivo = nomeDoAcorde
                    }
                    audioPiano.tocarAcorde(nomeDoAcorde: nomeDoAcorde)
                }
                
                do {
                    try await Task.sleep(for: .seconds(1))
                } catch {
                    break
                }
            }
            
            await MainActor.run {
                withAnimation(.easeInOut) {
                    self.acordeAtivo = nil
                }
            }
            progressionTask = nil
        }
    }
    
    private func StopAudio() {
        progressionTask?.cancel()
        progressionTask = nil
        withAnimation(.easeInOut) {
            acordeAtivo = nil
        }
    }
}

#Preview {
    VerticalMain()
        .environment(CarouselViewModel())
}
