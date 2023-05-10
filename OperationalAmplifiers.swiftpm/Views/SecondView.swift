//


import SwiftUI
import LaTeXSwiftUI

struct SecondView: View {
    
    @ObservedObject var appState: AppState
    
    @State private var currentScrollId = 0
    @State private var animateAmplification = false
    @State var gain: Double = 0
    @State private var buttonSize = CGSize(width: 1.0, height: 1.0)
    @State private var showLeftHStack = false
    @State private var showRightHStack = false
    @State private var showNextButton = false
    @State private var buttonText = "Next"
    @State private var R_in: Resistor = Resistor(value: 10000)
    @State private var R_f: Resistor = Resistor(value: 10000)
    
    private let maxScrollID = 3
    
    private var gainFormatted: String {
        String(format: "%.2f", gain)
    }
    
    
    var body: some View {
        VStack {
            
            Text("Inverting Amplifier")
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
                                                
                                                ResistorDragView(resistor: Resistor(value: 10000*(1+i)))
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
                                        
                                        Spacer()
                                        
                                        InvertingAmplifierView(R_in: $R_in, R_f: $R_f, gain: $gain)
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
                                    buttonText = "Learn more"
                                }
                                buttonSize = CGSize(width: 1.3, height: 1.3)
                            }
                            if currentScrollId > maxScrollID {
                                withAnimation {
                                    appState.previousPage = appState.currentPage
                                    appState.currentPage  = .third
                                }
                                
                            }
                            
                        } label: {
                            Text("Next")
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
                                        Text("Now the Op-Amp is used with ").font(AppHelperClass.textFont) + Text("external feedback resistors!").font(AppHelperClass.boldedTextFont)
                                    }
                                    .scrollViewFormatted()
                                    .padding(.top, 30)
                                    .opacity(currentScrollId >= 0 ? 1 : 0)
                                    .id(0)
                                    
                                    Group {
                                        Text("Because the inverting input terminal is used, the output voltage gain is ").font(AppHelperClass.textFont) + Text("negative.").font(AppHelperClass.boldedTextFont)
                                    }
                                    .scrollViewFormatted()
                                    .opacity(currentScrollId >= 1 ? 1 : 0)
                                    .id(1)
                                    
                                    Group {
                                        LaTeX("The gain is determined by the two resistors $R_{f}$ and $R_{in}$:")
                                            .scrollViewTextFormatted()
                                        LaTeX("$\\LARGE V_{out} = - \\frac{R_{f}}{R_{in}} * V_{in}$")
                                            .scrollViewTextFormatted()
                                            .frame(maxWidth: .infinity ,alignment: .center)
                                    }
                                    .opacity(currentScrollId >= 2 ? 1 : 0)
                                    .id(2)
                                    
                                    VStack(alignment: .leading) {
                                        Group {
                                            Text("As you can see in the diagram below, the output voltage is ").font(AppHelperClass.textFont) + Text("inverted ").font(AppHelperClass.boldedTextFont) + Text(". Try changing the resistors to see how the output voltage depends on them!").font(AppHelperClass.textFont)
                                            
                                            LaTeX("You can change the resistors by dragging from the top bar and dropping onto $R_{f}$ and $R_{in}$ respectively!").font(AppHelperClass.textFont)
                                        }
                                        .scrollViewFormatted()
                                        
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

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView(appState: AppState())
    }
}
