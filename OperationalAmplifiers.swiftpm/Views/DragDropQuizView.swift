//


import SwiftUI
import LaTeXSwiftUI





struct DragDropQuizView: View {
    
    @ObservedObject var dragDropQuizStatus: DragDropQuizStatus
    
    @Binding var animateWrongDrop: Bool
        
    @State private var wantedGain: Double = 0
    @State private var offeredOptions: [Int] = [Int]()
    @State private var userCorrect: Bool = false
    
    private var wantedGainFormatted: String {
        String(format: "%.2f", wantedGain)
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                
                LaTeX("How to achieve an output gain of $\\Large A=\(wantedGain)$ ?")
                    .font(AppHelperClass.boldedTextFont)
                    .padding(.vertical, geo.size.height*0.03)
                
                HStack {
                    ForEach(offeredOptions, id: \.self) { value in
                        ResistorDragView(resistor: Resistor(value: value))
                            .frame(maxWidth: geo.size.width*0.1)
                            .padding(.horizontal ,geo.size.width*0.02)
                        
                    }
                }
                .padding(.top, geo.size.width*0.015)
                .overlay {
                    RoundedRectangle(cornerRadius: 30)
                        .strokeBorder(style: StrokeStyle(lineWidth: 4))
                        .foregroundColor(.accentColor)
                }
                
                switch dragDropQuizStatus.dragDropQuizStatus {
                case .inverting:
                    DragDropQuizInvertingAmplifierView(animateWrongDrop: $animateWrongDrop, userCorrect: $userCorrect, wantedGain: $wantedGain, offeredOptions: $offeredOptions, regenerateBinding: $dragDropQuizStatus.currentQuestion, userScore: $dragDropQuizStatus.userScore)
                        .padding(.bottom, geo.size.height*0.03)
                case .nonInverting:
                    DragDropQuizNonInvertingAmplifierView(animateWrongDrop: $animateWrongDrop, userCorrect: $userCorrect, wantedGain: $wantedGain, offeredOptions: $offeredOptions, regenerateBinding: $dragDropQuizStatus.currentQuestion, userScore: $dragDropQuizStatus.userScore)
                        .padding(.bottom, geo.size.height*0.03)
                }
                
            }
            .frame(maxWidth: .infinity ,alignment: .center)
            
            
        }
        .onChange(of: userCorrect) { correct in
            if correct {
                
                dragDropQuizStatus.currentQuestion += 1
                
            }
        }
        //.offset(x: animateWrongDrop ? -30 : 0)
    }
}


struct DragDropQuizInvertingAmplifierView: View {
    
    @Binding var regenerateVar: Int
    @Binding private var wantedGain: Double
    @Binding private var offeredOptions: [Int]
    @Binding var userCorrect: Bool
    @Binding var userScore: Int
    @Binding private var animateWrongDrop: Bool // will change on false drop to trigger offset
    
    @State private var tempOfferedOptions: [Int]
    @State private var tempWantedGain: Double
    @State private var show_Initial_R_f_Value: Bool
    @State private var R_in: Resistor
    @State private var R_f: Resistor
    
    private let min_R_in_Value: Int
    private let numberOfOfferedChoices: Int
    
    
    var body: some View {
        InvertingAmplifierView(R_in: $R_in, R_f: $R_f, gain: .constant(0), evaluateDrop: true, showInitialValue_R_f: $show_Initial_R_f_Value, showInitialValue_R_in: .constant(true), animateWrongDrop: $animateWrongDrop, R_f_correct: $userCorrect, accept_R_in_Drop: .constant(false), accept_R_f_Drop: .constant(true), userScore: $userScore)
            .onAppear {
                self.offeredOptions = tempOfferedOptions
                self.wantedGain = tempWantedGain
            }
            .onChange(of: regenerateVar) { _ in
                regenerate()
            }
        
    }
    
    init(animateWrongDrop: Binding<Bool>, userCorrect: Binding<Bool>, wantedGain: Binding<Double>, offeredOptions: Binding<[Int]>, numberOfOfferedChoices: Int = 6, regenerateBinding: Binding<Int>, userScore: Binding<Int>) {
        self._animateWrongDrop = animateWrongDrop
        self._userCorrect = userCorrect
        self._wantedGain = wantedGain
        self._offeredOptions = offeredOptions
        self._regenerateVar = regenerateBinding
        self.numberOfOfferedChoices = numberOfOfferedChoices
        self.min_R_in_Value = 5000
        let generatedRandomWantedGain = -Double(Int.random(in: 1...10))/4
        let R_in_Value = Int.random(in: 1...10)*min_R_in_Value
        let R_f_Value = Int(generatedRandomWantedGain*Double(-R_in_Value))
        var tempOfferedOptions = [Int]()
        tempOfferedOptions.append(R_f_Value)
        for _ in 0..<numberOfOfferedChoices-1 {
            var addInt: Int
            repeat {
                addInt = Int.random(in: -R_f_Value/1000+1...R_f_Value/1000+25)*min_R_in_Value/5
            } while tempOfferedOptions.contains((R_f_Value+addInt))
            //let appendValue = R_f_Value > addInt ? (Bool.random() ? R_f_Value + addInt : R_f_Value - addInt) : R_f_Value + addInt
            tempOfferedOptions.append(R_f_Value + addInt)
        }
        tempOfferedOptions.shuffle()
        self.R_in = Resistor(value: R_in_Value)
        self.R_f = Resistor(value: R_f_Value)
        self.tempOfferedOptions = tempOfferedOptions
        self.tempWantedGain = generatedRandomWantedGain
        self.show_Initial_R_f_Value = false
        self._userScore = userScore

    }
    
    func regenerate() {
        let generatedRandomWantedGain = -Double(Int.random(in: 1...10))/4
        let R_in_Value = Int.random(in: 1...10)*min_R_in_Value
        let R_f_Value = Int(generatedRandomWantedGain*Double(-R_in_Value))
        var tempOfferedOptions = [Int]()
        tempOfferedOptions.append(R_f_Value)
        for _ in 0..<numberOfOfferedChoices-1 {
            var addInt: Int
            repeat {
                addInt = Int.random(in: -R_f_Value/1000+1...R_f_Value/1000+25)*min_R_in_Value/5
            } while tempOfferedOptions.contains((R_f_Value+addInt))
            //let appendValue = R_f_Value > addInt ? (Bool.random() ? R_f_Value + addInt : R_f_Value - addInt) : R_f_Value + addInt
            tempOfferedOptions.append(R_f_Value + addInt)
        }
        tempOfferedOptions.shuffle()
        self.tempOfferedOptions = tempOfferedOptions
        self.tempWantedGain = generatedRandomWantedGain
        self.offeredOptions = tempOfferedOptions
        self.wantedGain = tempWantedGain
        withAnimation(.easeInOut(duration: 0.5).delay(0.5)) {
            self.R_in = Resistor(value: R_in_Value)
            self.R_f = Resistor(value: R_f_Value)
            
            self.show_Initial_R_f_Value = false
            self.userCorrect = false
        }
        
    }
}

struct DragDropQuizNonInvertingAmplifierView: View {
    
    @Binding var regenerateVar: Int
    @Binding private var wantedGain: Double
    @Binding private var offeredOptions: [Int]
    @Binding var userCorrect: Bool
    @Binding var userScore: Int
    @Binding private var animateWrongDrop: Bool     // will change on false drop to trigger offset

    @State private var R_1: Resistor
    @State private var R_f: Resistor
    @State private var tempOfferedOptions: [Int]
    @State private var tempWantedGain: Double
    @State private var show_Initial_R_f_Value: Bool
    private let min_R_Value: Int
    private let numberOfOfferedChoices: Int
    
    var body: some View {
        NonInvertingAmplifierView(R_1: $R_1, R_f: $R_f, gain: .constant(0), evaluateDrop: true, showInitialValue_R_f: $show_Initial_R_f_Value, showInitialValue_R_1: .constant(true), animateWrongDrop: $animateWrongDrop, R_f_correct: $userCorrect, accept_R_1_Drop: .constant(false), accept_R_f_Drop: .constant(true), userScore: $userScore)
            .onAppear {
                self.offeredOptions = tempOfferedOptions
                self.wantedGain = tempWantedGain
            }
            .onChange(of: regenerateVar) { _ in
                regenerate()
            }
        
    }
    
    init(animateWrongDrop: Binding<Bool>, userCorrect: Binding<Bool>, wantedGain: Binding<Double>, offeredOptions: Binding<[Int]>, numberOfOfferedChoices: Int = 6, regenerateBinding: Binding<Int>, userScore: Binding<Int>) {
        self._animateWrongDrop = animateWrongDrop
        self._userCorrect = userCorrect
        self._wantedGain = wantedGain
        self._offeredOptions = offeredOptions
        self._regenerateVar = regenerateBinding
        self.numberOfOfferedChoices = numberOfOfferedChoices
        self.min_R_Value = 5000
        let generatedRandomWantedGain = Double(Int.random(in: 3...13))/2
        let R_1_Value = Int.random(in: 1...10)*min_R_Value
        let R_f_Value = Int((generatedRandomWantedGain-1)*Double(R_1_Value))
        var tempOfferedOptions = [Int]()
        tempOfferedOptions.append(R_f_Value)
        for _ in 0..<numberOfOfferedChoices-1 {
            var addInt: Int
            repeat {
                addInt = Int.random(in: -R_f_Value/1000+1...R_f_Value/1000+25)*min_R_Value/5
            } while tempOfferedOptions.contains((R_f_Value+addInt))
            //let appendValue = R_f_Value > addInt ? (Bool.random() ? R_f_Value + addInt : R_f_Value - addInt) : R_f_Value + addInt
            tempOfferedOptions.append(R_f_Value + addInt)
        }
        tempOfferedOptions.shuffle()
        self.R_1 = Resistor(value: R_1_Value)
        self.R_f = Resistor(value: R_f_Value)
        self.tempOfferedOptions = tempOfferedOptions
        self.tempWantedGain = generatedRandomWantedGain
        self.show_Initial_R_f_Value = false
        self._userScore = userScore
    }
    
    func regenerate() {
        let generatedRandomWantedGain = Double(Int.random(in: 3...13))/2
        let R_1_Value = Int.random(in: 1...10)*min_R_Value
        let R_f_Value = Int((generatedRandomWantedGain-1)*Double(R_1_Value))
        var tempOfferedOptions = [Int]()
        tempOfferedOptions.append(R_f_Value)
        for _ in 0..<numberOfOfferedChoices-1 {
            var addInt: Int
            repeat {
                addInt = Int.random(in: -R_f_Value/1000+1...R_f_Value/1000+25)*min_R_Value/5
            } while tempOfferedOptions.contains((R_f_Value+addInt))
            //let appendValue = R_f_Value > addInt ? (Bool.random() ? R_f_Value + addInt : R_f_Value - addInt) : R_f_Value + addInt
            tempOfferedOptions.append(R_f_Value + addInt)
        }
        tempOfferedOptions.shuffle()
        self.tempOfferedOptions = tempOfferedOptions
        self.tempWantedGain = generatedRandomWantedGain
        self.offeredOptions = tempOfferedOptions
        self.wantedGain = tempWantedGain
        withAnimation(.easeInOut(duration: 0.5).delay(0.5)) {
            self.R_1 = Resistor(value: R_1_Value)
            self.R_f = Resistor(value: R_f_Value)
            
            self.show_Initial_R_f_Value = false
            self.userCorrect = false
        }
    }
    
    
}


struct DragDropQuizViewPreview: View {
    
    @StateObject var dragDropQuizStatus = DragDropQuizStatus()
    
    @State private var regenerate: Int = 0
    @State private var userScore: Int = 0
    @State private var animateWrongDrop = false
    @State private var userCorrect = false
    
    var body: some View {
        
        VStack {
            Text("user correct: \(userCorrect.description)")
            Stepper(value: $regenerate) {
                Text("Regenerate \(regenerate)")
            }
            .onChange(of: regenerate) { newValue in
                
                withAnimation(.easeInOut(duration: 0.5).delay(0.2)) {
                    dragDropQuizStatus.toggle()
                }
            }
            
            DragDropQuizView(dragDropQuizStatus: dragDropQuizStatus, animateWrongDrop: $animateWrongDrop)
        }
    }
    
}


struct DragDropQuizView_Previews: PreviewProvider {
    static var previews: some View {
        DragDropQuizViewPreview()
    }
}
