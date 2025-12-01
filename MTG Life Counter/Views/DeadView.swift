//
//  DeadView.swift
//  MTG Life Counter
//
//  Created by Joseph Gilmore on 12/1/25.
//


import SwiftUI

struct DeadView: View {
    @State private var quoteViewModel = QuoteViewModel()
    @State private var rotationAngle: Double = 0
    @State private var lastDragValue: Double = 0
    
    var player: Player

    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    if let quote = player.deathQuote {
                        Text(quote.quote)
                            .multilineTextAlignment(.center)
                        Text("-\(quote.card)")
                            .multilineTextAlignment(.center)
                    }
                }
                .font(.footnote)
                .monospaced()
                .foregroundStyle(.white)
                
                Text(
"""
                          ...----....
                      ..-:"''         ''"-..
                   .-'                      '-.
                 .'              .     .       '.
               .'   .          .    .      .    .''.
             .'  .    .       .   .   .     .   . ..:.
           .' .   . .  .       .   .   ..  .   . ....::.
          ..   .   .      .  .    .     .  ..  . ....:IA.
         .:  .   .    .    .  .  .    .. .  .. .. ....:IA.
        .: .   .   ..   .    .     . . .. . ... ....:.:VHA.
        '..  .  .. .   .       .  . .. . .. . .....:.::IHHB.
       .:. .  . .  . .   .  .  . . . ...:.:... .......:HIHMM.
      .:.... .   . ."::"'.. .   .  . .:.:.:II;,. .. ..:IHIMMA
      ':.:..  ..::IHHHHHI::. . .  ...:.::::.,,,. . ....VIMMHM
     .:::I. .AHHHHHHHHHHAI::. .:...,:IIHHHHHHMMMHHL:. . VMMMM
    .:.:V.:IVHHHHHHHMHMHHH::..:" .:HIHHHHHHHHHHHHHMHHA. .VMMM.
    :..V.:IVHHHHHMMHHHHHHHB... . .:VPHHMHHHMMHHHHHHHHHAI.:VMMI
    ::V..:VIHHHHHHMMMHHHHHH. .   .I":IIMHHMMHHHHHHHHHHHAPI:WMM
    ::". .:.HHHHHHHHMMHHHHHI.  . .:..I:MHMMHHHHHHHHHMHV:':H:WM
    :: . :.::IIHHHHHHMMHHHHV  .ABA.:.:IMHMHMMMHMHHHHV:'. .IHWW
    '.  ..:..:.:IHHHHHMMHV" .AVMHMA.:.'VHMMMMHHHHHV:' .  :IHWV
     :.  .:...:".:.:TPP"   .AVMMHMMA.:. "VMMHHHP.:... .. :IVAI
    .:.   '... .:"'   .   ..HMMMHMMMA::. ."VHHI:::....  .:IHW'
    ...  .  . ..:IIPPIH: ..HMMMI.MMMV:I:.  .:ILLH:.. ...:I:IM
  : .   .'"' .:.V". .. .  :HMMM:IMMMI::I. ..:HHIIPPHI::'.P:HM.
  :.  .  .  .. ..:.. .    :AMMM IMMMM..:...:IV":T::I::.".:IHIMA
  'V:.. .. . .. .  .  .   'VMMV..VMMV :....:V:.:..:....::IHHHMH
    "IHH:.II:.. .:. .  . . . " :HB"" . . ..PI:.::.:::..:IHHMMV"
     :IP""HHII:.  .  .    . . .'V:. . . ..:IH:.:.::IHIHHMMMMM"
     :V:. VIMA:I..  .     .  . .. . .  .:.I:I:..:IHHHHMMHHMMM
     :"VI:.VWMA::. .:      .   .. .:. ..:.I::.:IVHHHMMMHMMMMI
     :."VIIHHMMA:.  .   .   .:  .:.. . .:.II:I:AMMMMMMHMMMMMI
     :..VIHIHMMMI...::.,:.,:!"I:!"I!"I!"V:AI:VAMMMMMMHMMMMMM'
     ':.:HIHIMHHA:"!!"I.:AXXXVVXXXXXXXA:."HPHIMMMMHHMHMMMMMV
       V:H:I:MA:W'I :AXXXIXII:IIIISSSSSSXXA.I.VMMMHMHMMMMMM
         'I::IVA ASSSSXSSSSBBSBMBSSSSSSBBMMMBS.VVMMHIMM'"'
          I:: VPAIMSSSSSSSSSBSSSMMBSSSBBMMMMXXI:MMHIMMI
         .I::. "H:XIIXBBMMMMMMMMMMMMMMMMMBXIXXMMPHIIMM'
         :::I.  ':XSSXXIIIIXSSBMBSSXXXIIIXXSMMAMI:.IMM
         :::I:.  .VSSSSSISISISSSBII:ISSSSBMMB:MI:..:MM
         ::.I:.  ':"SSSSSSSISISSXIIXSSSSBMMB:AHI:..MMM.
         ::.I:. . ..:"BBSSSSSSSSSSSSBBBMMMB:AHHI::.HMMI
         :..::.  . ..::":BBBBBSSBBBMMMB:MMMMHHII::IHHMI
         ':.I:... ....:IHHHHHMMMMMMMMMMMMMMMHHIIIIHMMV"
           "V:. ..:...:.IHHHMMMMMMMMMMMMMMMMHHHMHHMHP'
            ':. .:::.:.::III::IHHHHMMMMMHMHMMHHHHM"
              "::....::.:::..:..::IIIIIHHHHMMMHHMV"
                "::.::.. .. .  ...:::IIHHMMMMHMV"
                  "V::... . .I::IHHMMV"'
                    '"VHVHHHAHHHHMMV:"'
""")
                    .font(.system(size: 3, weight: .regular, design: .monospaced))
                    .foregroundColor(.red)
                    .multilineTextAlignment(.leading)
                    .rotationEffect(.degrees(rotationAngle))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let currentAngle = atan2(value.translation.height, value.translation.width) * 180 / .pi
                                let deltaAngle = currentAngle - lastDragValue
                                rotationAngle += deltaAngle
                                lastDragValue = currentAngle
                            }
                            .onEnded { _ in
                                lastDragValue = 0
                            }
                    )
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .task {
            if player.deathQuote == nil {
                await quoteViewModel.getQuote()
                player.deathQuote = quoteViewModel.quote
            }
        }
    }
}

#Preview {
    DeadView(player: Player(name: "Joseph", color: "red"))
}
