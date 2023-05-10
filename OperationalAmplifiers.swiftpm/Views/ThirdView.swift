//


import SwiftUI
import LaTeXSwiftUI

struct ThirdView: View {
    
    @ObservedObject var appState: AppState
    
    @State private var currentScrollId = 0
    @State private var animateAmplification = false
    @State var gain: Double = 0
    @State private var buttonSize = CGSize(width: 1.0, height: 1.0)
    @State private var showLeftHStack = false
    @State private var showRightHStack = false
    @State private var showNextButton = false
    @State private var buttonText = "Next"
    @State private var R_1: Resistor = Resistor(value: 10000)
    @State private var R_f: Resistor = Resistor(value: 10000)
    
    private let maxScrollID = 3
    
    private var gainFormatted: String {
        String(format: "%.2f", gain)
    }
    
    var body: some View {
        VStack {
            
            Text("Non-Inverting Amplifier")
                .font(.custom("Orbitron-Bold", size: 40))
                .padding(10)
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 2)
                .foregroundColor(.accentColor)
                .padding(.top, 5)
            
            
            GeometryReader { geoProxy in
                HStack {
                    VStack {
                        GeometryReader { geo in
                            
                            BackgroundRectangleView {
                                GeometryReader { g in
                                    VStack {
                                        HStack {
                                            ForEach(0..<3) { i in
                                                Spacer()
                                                ResistorDragView(resistor: Resistor(value: 5000*(2+i)))
                                                    .frame(width: g.size.width*0.2)
                                                
                                            }
                                            Spacer()
                                            
                                        }
                                        .padding(.top,g.size.width*0.025)
                                        .frame(width: g.size.width)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 30)
                                                .strokeBorder(style: StrokeStyle(lineWidth: 4))
                                                .foregroundColor(.accentColor)
                                        }
                                        
                                        Spacer()
                                        
                                        
                                        LaTeX("$Output\\:Gain\\: A = \(gainFormatted)$")
                                            .scaleEffect(1.2)
                                            .padding(.top, geo.size.height*0.02)
                                        
                                        
                                        
                                        Spacer()
                                        
                                        
                                        NonInvertingAmplifierView(R_1: $R_1, R_f: $R_f, gain: $gain)
                                            .padding(.bottom, g.size.height*0.05)
                                        
                                    }
                                }
                                
                                
                            }
                            
                        }
                        
                        
                        Button {
                            withAnimation {
                                currentScrollId += 1
                            }
                            
                            if currentScrollId == 3 {
                                animateAmplification = true
                            }
                            if currentScrollId > maxScrollID-1 {
                                withAnimation(.none) {
                                    buttonText = "Let's do a quiz!"
                                    
                                }
                                
                                buttonSize = CGSize(width: 1.3, height: 1.3)
                            }
                            if currentScrollId > maxScrollID {
                                withAnimation {
                                    appState.previousPage = appState.currentPage
                                    appState.currentPage  = .quiz
                                }
                                
                            }
                            
                        } label: {
                            
                            Text(buttonText)
                                .font(.custom("Quicksand-Bold", size: 32))
                                .irregularGradient(colors: [ .white], background: Color.accentColor, animate: true, speed: 1)
                                .padding(.bottom)
                                .scaleEffect(buttonSize)
                                .onAppear{
                                    buttonSize = CGSize(width: 1.1, height: 1.1)
                                }
                                .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: buttonSize)
                        }
                        .opacity(showNextButton ? 1 : 0)
                        
                        
                        
                    }
                    .opacity(showLeftHStack ? 1 : 0)
                    
                    
                    GeometryReader { geo in
                        ScrollViewReader { scrollViewReader in
                            ScrollView {
                                VStack(alignment: .leading, spacing: 0) {
                                    Group {
                                        Text("In the ").font(AppHelperClass.textFont) + Text("non-inverting operation").font(AppHelperClass.boldedTextFont) + Text(", the input voltage is connected to the non-inverting input terminal.").font(AppHelperClass.textFont)
                                        
                                    }
                                    .scrollViewFormatted()
                                    .padding(.top, 30)
                                    .opacity(currentScrollId >= 0 ? 1 : 0)
                                    .id(0)
                                    .font(.callout)
                                    
                                    Group {
                                        Text("As a result, the ").font(AppHelperClass.textFont) + Text("output gain ").font(AppHelperClass.boldedTextFont) + Text("of the amplifier is positive.").font(AppHelperClass.textFont)
                                    }
                                    .scrollViewFormatted()
                                    .opacity(currentScrollId >= 1 ? 1 : 0)
                                    .id(1)
                                    
                                    Group {
                                        LaTeX("Similar to the inverting amplifier, the gain is determined by the resistors $R_{f}$ and $R_{1}$:")
                                            .scrollViewTextFormatted()
                                        
                                        LaTeX("$\\LARGE V_{out} = \\bigg(1+\\frac{R_{f}}{R_{1}}\\bigg)*V_{in}$")
                                            .scrollViewTextFormatted()
                                            .frame(maxWidth: .infinity ,alignment: .center)
                                    }
                                    .opacity(currentScrollId >= 2 ? 1 : 0)
                                    .id(2)
                                    
                                    
                                    VStack(alignment: .leading) {
                                        Text("Try differtent combinations of resistors to see how it effects the output voltage!")
                                            .scrollViewTextFormatted()
                                        
                                        
                                        DynamicAmplificationView2(animate: $animateAmplification, amplification: $gain)
                                            .aspectRatio(1.5, contentMode: .fit)
                                            .padding(.leading, 5)
                                        
                                    }
                                    .padding(.vertical, 10)
                                    .padding(.bottom, 40)
                                    .opacity(currentScrollId >= 3 ? 1 : 0)
                                    .id(3)
                                    
                                    
                                    
                                }
                                .padding(.trailing, 20)
                                .padding(.leading)
                                .onChange(of: currentScrollId) { newValue in
                                    
                                    withAnimation {
                                        scrollViewReader.scrollTo(newValue)
                                    }
                                }
                            }
                        }
                        .opacity(showRightHStack ? 1 : 0)
                    }
                    .frame(width: geoProxy.size.width*0.4)
                    
                    
                }
            }
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                withAnimation(.easeInOut(duration: 1)) {
                    showLeftHStack = true
                    
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                withAnimation(.easeInOut(duration: 1)) {
                    showRightHStack = true
                    
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                withAnimation(.easeInOut(duration: 1)) {
                    showNextButton = true
                    
                }
            }
        }
    }
}

struct ThirdView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdView(appState: AppState())
    }
}
