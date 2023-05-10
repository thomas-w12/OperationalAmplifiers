//


import SwiftUI
import LaTeXSwiftUI
import ConfettiSwiftUI

struct FirstView: View {
    
    @ObservedObject var appState: AppState
    
    @State private var currentScrollId = 0
    @State private var animateAmplification = false
    @State private var buttonText = "Next"
    @State private var buttonSize = CGSize(width: 1, height: 1)
    @State private var showLeftHStack = false
    @State private var showRightHStack = false
    @State private var showNextButton = false
    @State private var showSlider = false
    @State private var amplification = 1.3
    @State private var confetti = 0
    
    let maxScrollID = 6
    
    private var amplificationFormatted: String {
        String(format: "%.2f", amplification)
    }
    
    
    var body: some View {
        VStack {
            
            Text("What is an Operational Amplifier?")
                .font(.custom("Orbitron-Bold", size: 40))
                .padding(10)
            
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 2)
                .foregroundColor(.accentColor)
                .padding(5)
            
            GeometryReader { geoProxy in
                HStack {
                    GeometryReader { geo in
                        if showLeftHStack {
                            VStack {
                                OpAmpAnimatedView()
                                    .frame(height: geo.size.height*0.9)
                                if showNextButton {
                                    Button {
                                        
                                        withAnimation {
                                            if currentScrollId != 2 {
                                                currentScrollId += 1
                                            }
                                        }
                                        
                                        if currentScrollId == 2 {
                                            animateAmplification = true
                                        }
                                        if currentScrollId > maxScrollID-1 {
                                            withAnimation(.none) {
                                                buttonText = "Learn more"
                                            }
                                            buttonSize = CGSize(width: 1.3, height: 1.3)
                                        }
                                        if currentScrollId > maxScrollID {
                                            withAnimation {
                                                appState.previousPage = appState.currentPage
                                                appState.currentPage  = .second
                                                
                                            }
                                            
                                        }
                                        
                                    } label: {
                                        
                                        Text(buttonText)
                                            .font(.custom("Quicksand-Bold", size: 32))
                                            .irregularGradient(colors: [ .white], background: Color.accentColor, animate: true, speed: 1)
                                            .padding(.bottom, geo.size.height*0.05)
                                            .scaleEffect(buttonSize)
                                            .onAppear{
                                                buttonSize = CGSize(width: 1.1, height: 1.1)
                                            }
                                            .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: buttonSize)
                                    }
                                }
                                
                            }
                        }
                        
                    }
                    .frame(width: geoProxy.size.width*0.5)
                    
                    if showRightHStack {
                        
                        GeometryReader { geo in
                            ScrollViewReader { scrollViewReader in
                                
                                ScrollView {
                                    VStack(alignment: .leading, spacing: 0) {
                                        
                                        Group {
                                            Text("An ").font(AppHelperClass.textFont) + Text("Operational Amplifier ").font(AppHelperClass.boldedTextFont) + Text("(op-amp for short) is basically a ").font(AppHelperClass.textFont) + Text("voltage amplifying device ").font(AppHelperClass.boldedTextFont) + Text("with adjustable behaviour.").font(AppHelperClass.textFont)
                                        }
                                        .scrollViewFormatted()
                                        .padding(.top, 30)
                                        .id(0)
                                        .opacity(currentScrollId >= 0 ? 1 : 0)
                                        
                                        Group {
                                            Text("But what does voltage amplifying mean?")
                                                .font(AppHelperClass.textFont)
                                            
                                            
                                            Text("Voltage amplifying is the process of turning a given input voltage into a ").font(AppHelperClass.textFont) + Text("magnified, accurate replica ").font(AppHelperClass.boldedTextFont) + Text("of this voltage as an output voltage.").font(AppHelperClass.textFont)
                                            
                                        }
                                        .scrollViewFormatted()
                                        .id(1)
                                        .opacity(currentScrollId >= 1 ? 1 : 0)
                                        
                                        VStack {
                                            AmplificationView(animate: $animateAmplification, amplification: $amplification)
                                                .aspectRatio(2.5 ,contentMode: .fit)
                                                .padding(.horizontal)
                                            VStack {
                                                LaTeX("Try to adjust the gain: $A=\(amplificationFormatted)$")
                                                    .font(AppHelperClass.boldedTextFont)
                                                
                                                Slider(value: $amplification, in: 0...1.7, step: 0.01) {
                                                    Text("Slider to adjust amplification")
                                                } onEditingChanged: { editing in
                                                    if !editing {
                                                        confetti += 1
                                                        if currentScrollId == 2 {
                                                            withAnimation {
                                                                currentScrollId += 1
                                                            }
                                                        }
                                                    }
                                                }
                                                
                                            }
                                            .scrollViewFormatted()
                                            .opacity(showSlider ? 1 : 0)
                                        }
                                        .padding(.vertical, 20)
                                        .id(2)
                                        .opacity(currentScrollId >= 2 ? 1 : 0)
                                        .confettiCannon(counter: $confetti)
                                        
                                        VStack(alignment: .leading) {
                                            Group {
                                                Text("How the output voltage depends on the input voltage is determined by the circuitry.").font(AppHelperClass.textFont)
                                                Text("This is called the ").font(AppHelperClass.textFont) + Text("operation ").font(AppHelperClass.boldedTextFont) + Text("of the Op-Amp.").font(AppHelperClass.textFont)
                                                
                                            }
                                        }
                                        .scrollViewFormatted()
                                        .id(3)
                                        .opacity(currentScrollId >= 3 ? 1 : 0)
                                        
                                        
                                        VStack(alignment: .leading) {
                                            Group {
                                                Text("As you can see on the symbol on the left, an Op-Amp has ").font(AppHelperClass.textFont) + Text("two input terminals ").font(AppHelperClass.boldedTextFont) + Text("and ").font(AppHelperClass.textFont) + Text("one output terminal.").font(AppHelperClass.boldedTextFont)
                                                Text("The input with the minus symbol is called inverting input, the one with the plus symbol is called non-inverting input. ").font(AppHelperClass.textFont)
                                            }
                                            
                                        }
                                        .scrollViewFormatted()
                                        .id(4)
                                        .opacity(currentScrollId >= 4 ? 1 : 0)
                                        
                                        
                                        Text("Because of their capabilities, Op-Amps are one of the fundamental building blocks of Analogue Electronic Circuits! ")
                                            .scrollViewTextFormatted()
                                            .id(5)
                                            .opacity(currentScrollId >= 5 ? 1 : 0)
                                        
                                        Text("On the next pages we will take look at the different operations an Op-Amp can be used in! ")
                                            .scrollViewTextFormatted()
                                            .id(6)
                                            .opacity(currentScrollId >= 6 ? 1 : 0)
                                        
                                        
                                        
                                    }
                                    .padding(.trailing, 20)
                                    .onChange(of: currentScrollId) { newValue in
                                        
                                        withAnimation {
                                            scrollViewReader.scrollTo(newValue)
                                        }
                                    }
                                }
                                .padding(.bottom, geo.size.height*0.08)
                            }
                        }
                        .frame(width: geoProxy.size.width*0.5)
                    }
                }
            }
            
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                withAnimation(.easeInOut(duration: 1)) {
                    showLeftHStack = true
                    
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+4.5) {
                withAnimation(.easeInOut(duration: 1)) {
                    showRightHStack = true
                    
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+5) {
                withAnimation(.easeInOut(duration: 1)) {
                    showNextButton = true
                    
                }
            }
        }
        .onChange(of: animateAmplification) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now()+3.5) {
                withAnimation(.easeInOut(duration: 1)) {
                    showSlider = true
                    
                }
            }
        }
        
    }
    
}



struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView(appState: AppState.init())
    }
}
