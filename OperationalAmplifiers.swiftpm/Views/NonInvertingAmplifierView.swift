//


import SwiftUI
import LaTeXSwiftUI

struct NonInvertingAmplifierView: View {
    
    @Binding var R_1: Resistor
    @Binding var R_f: Resistor
    @Binding var gain: Double
    @Binding private var animateWrongDrop: Bool
    @Binding var R_f_correct: Bool
    @Binding var R_1_correct: Bool
    @Binding var userScore: Int
    @Binding var showInitialValue_R_f: Bool
    @Binding var showInitialValue_R_1: Bool
    @Binding var accept_R_f_Drop: Bool
    @Binding var accept_R_1_Drop: Bool
    
    private var evaluateDrop: Bool
    
    var amplification: Double {
        return (1.0 + Double(R_f.value)/Double(R_1.value))
    }
    

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ResistorDropView(resistor: $R_f, showValue: $showInitialValue_R_f, evaluateDrop: evaluateDrop, resistorNameLateXString: "$R_{f}$", textRotationAngle: Angle(degrees: -90), animateWrongDrop: $animateWrongDrop, userCorrect: $R_f_correct, acceptDrop: $accept_R_f_Drop, userScore: $userScore)
                    .rotationEffect(Angle(degrees: 90))
                    .frame(width: geo.size.width*0.1618)
                    .position(x: geo.size.width*0.73878, y: geo.size.height*0.50188)
                    
                ResistorDropView(resistor: $R_1, showValue: $showInitialValue_R_1, evaluateDrop: evaluateDrop, resistorNameLateXString: "$R_{1}$", textRotationAngle: Angle(degrees: -90), animateWrongDrop: $animateWrongDrop, userCorrect: $R_1_correct, acceptDrop: $accept_R_1_Drop)
                    .rotationEffect(Angle(degrees: 90))
                    .frame(width: geo.size.width*0.16316)
                    .position(x: geo.size.width*0.73878, y: geo.size.height*0.80631)

                NonInvertingAmplifierShape()
                    .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                

                LaTeX("$V_{in}$")
                    .font(AppHelperClass.textFont)
                    .scaleEffect(1.5)
                    .position(x: geo.size.width*0.05, y: geo.size.height*0.5)

                LaTeX("$V_{out}$")
                    .font(AppHelperClass.textFont)
                    .scaleEffect(1.5)
                    .position(x: geo.size.width*0.95, y: geo.size.height*0.6)
                
                Circle()
                    .frame(width: geo.size.height*0.025)
                    .position(x: geo.size.width*0.73878, y: geo.size.height*0.27822)
                                
                Circle()
                    .frame(width: geo.size.height*0.025)
                    .position(x: geo.size.width*0.73878, y: geo.size.height*0.65553)
                
                
            }
        }
        .aspectRatio(15/11, contentMode: .fit)
        .onAppear {
            self.gain = amplification
        }
        .onChange(of: R_f) { newValue in
            gain = amplification
        }
        .onChange(of: R_1) { newValue in
            gain = amplification
        }
    }
    
    init(R_1: Binding<Resistor>, R_f: Binding<Resistor>, gain: Binding<Double>, evaluateDrop: Bool = false, showInitialValue_R_f: Binding<Bool> = .constant(true), showInitialValue_R_1: Binding<Bool> = .constant(true), animateWrongDrop: Binding<Bool> = .constant(false), R_f_correct: Binding<Bool> = .constant(true), R_1_correct: Binding<Bool> = .constant(true), accept_R_1_Drop: Binding<Bool> = .constant(true), accept_R_f_Drop: Binding<Bool> = .constant(true), userScore: Binding<Int> = .constant(0)) {
        self._R_1 = R_1
        self._R_f = R_f
        self._gain = gain
        self._animateWrongDrop = animateWrongDrop
        self.evaluateDrop = evaluateDrop
        self._showInitialValue_R_f = showInitialValue_R_f
        self._showInitialValue_R_1 = showInitialValue_R_1
        self._R_f_correct = R_f_correct
        self._R_1_correct = R_1_correct
        self._accept_R_1_Drop = accept_R_1_Drop
        self._accept_R_f_Drop = accept_R_f_Drop
        self._userScore = userScore
    }
}

// PreviewContent

struct NonInvAmpPreview: View {
    
    @State private var R_1 = Resistor(value: 10)
    @State private var R_f = Resistor(value: 100)
    @State private var gain: Double = 0
    
    var body: some View {
        VStack {
            
            HStack {
                ForEach(0..<3) { i in
                    ResistorDragView(resistor: Resistor(value: 10000*(1+i)))
                        .padding([.top, .horizontal],100)
                }
                
            }
            
            Group {
                Text("Gain: \(gain)")
                Text("Test")
            }
            
            
            NonInvertingAmplifierView(R_1: $R_1, R_f: $R_f, gain: $gain)
                

        }

    }
}
struct NonInvertingAmplifierView_Previews: PreviewProvider {
    static var previews: some View {
        NonInvAmpPreview()
    }
}
