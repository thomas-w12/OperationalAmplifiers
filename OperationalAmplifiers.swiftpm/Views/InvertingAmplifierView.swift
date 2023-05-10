//


import SwiftUI
import LaTeXSwiftUI


struct InvertingAmplifierView: View {
    
    @Binding var R_in: Resistor
    @Binding var R_f: Resistor
    @Binding var gain: Double
    @Binding private var animateWrongDrop: Bool
    @Binding var R_f_correct: Bool
    @Binding var R_in_correct: Bool
    @Binding var userScore: Int
    @Binding var showInitialValue_R_f: Bool
    @Binding var showInitialValue_R_in: Bool
    @Binding var accept_R_f_Drop: Bool
    @Binding var accept_R_in_Drop: Bool
    
    private var evaluateDrop: Bool
    
    var amplification: Double {
        return Double(-R_f.value)/Double(R_in.value)
    }
    
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ResistorDropView(resistor: $R_f, showValue: $showInitialValue_R_f, evaluateDrop: evaluateDrop, resistorNameLateXString: "$R_{f}$", animateWrongDrop: $animateWrongDrop, userCorrect: $R_f_correct, acceptDrop: $accept_R_f_Drop, userScore: $userScore)
                    .frame(width: geo.size.width*0.13932)
                    .position(x: geo.size.width*0.61743, y: geo.size.height*0.193225)
                
                ResistorDropView(resistor: $R_in, showValue: $showInitialValue_R_in, evaluateDrop: evaluateDrop, resistorNameLateXString: "$R_{in}$", animateWrongDrop: $animateWrongDrop, userCorrect: $R_in_correct, acceptDrop: $accept_R_in_Drop)
                    .frame(width: geo.size.width*0.13932)
                    .position(x: geo.size.width*0.21562, y: geo.size.height*0.484215)
                
                InvertingAmplifierShape()
                    .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                
                
                LaTeX("$V_{in}$")
                    .font(AppHelperClass.textFont)
                    .scaleEffect(1.5)
                    .position(x: geo.size.width*0.1, y: geo.size.height*0.65)
                
                LaTeX("$V_{out}$")
                    .font(AppHelperClass.textFont)
                    .scaleEffect(1.5)
                    .position(x: geo.size.width*0.95, y: geo.size.height*0.73)
                
                Circle()
                    .frame(width: geo.size.height*0.025)
                    .position(x: geo.size.width*0.80346, y: geo.size.height*0.58891)
                
                Circle()
                    .frame(width: geo.size.height*0.025)
                    .position(x: geo.size.width*0.36514, y: geo.size.height*0.48415)
                
                
                
                
            }
        }
        .aspectRatio(1.5, contentMode: .fit)
        .onAppear {
            self.gain = amplification
        }
        .onChange(of: R_f) { newValue in
            gain = amplification
        }
        .onChange(of: R_in) { newValue in
            gain = amplification
        }
        
    }
    
    init(R_in: Binding<Resistor>, R_f: Binding<Resistor>, gain: Binding<Double>, evaluateDrop: Bool = false, showInitialValue_R_f: Binding<Bool> = .constant(true), showInitialValue_R_in: Binding<Bool> = .constant(true), animateWrongDrop: Binding<Bool> = .constant(false), R_f_correct: Binding<Bool> = .constant(true), R_in_correct: Binding<Bool> = .constant(true), accept_R_in_Drop: Binding<Bool> = .constant(true), accept_R_f_Drop: Binding<Bool> = .constant(true), userScore: Binding<Int> = .constant(0)) {
        self._R_in = R_in
        self._R_f = R_f
        self._gain = gain
        self._animateWrongDrop = animateWrongDrop
        self.evaluateDrop = evaluateDrop
        self._showInitialValue_R_f = showInitialValue_R_f
        self._showInitialValue_R_in = showInitialValue_R_in
        self._R_f_correct = R_f_correct
        self._R_in_correct = R_in_correct
        self._accept_R_in_Drop = accept_R_in_Drop
        self._accept_R_f_Drop = accept_R_f_Drop
        self._userScore = userScore
    }
    
}

// Preview Content

struct InvAmpPreview: View {
    
    @State private var R_in = Resistor(value: 10)
    @State private var R_f = Resistor(value: 10)
    @State private var gain: Double = 1.0
    
    var body: some View {
        VStack {
            
            HStack {
                ForEach(0..<3) { i in
                    ResistorDragView(resistor: Resistor(value: 10000*(1+i)))
                }
                
            }
            
            Text("Gain: \(gain)")
            
            InvertingAmplifierView(R_in: $R_in, R_f: $R_f, gain: $gain)
            
        }
        
    }
}

struct InvertingAmplifierView_Previews: PreviewProvider {
    static var previews: some View {
        InvAmpPreview()
        
    }
}

