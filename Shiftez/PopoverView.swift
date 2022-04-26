//
//  PopoverView.swift
//  Shiftez
//
//  Created by Daniel Ivanov on 26/04/22.
//

import SwiftUI


struct PopoverView: View {
    
    @State var otp : String = ""
    @State var arn : String = ""
    
    @State var selectedProfile: String = ""
    @State var selectedIAMProfile: String = ""
    @State var profiles: [String] = []
    
    @State var dir: String = ""
    
    var body: some View {
        VStack(spacing: 16) {
            Text("ShiftEz").font(.largeTitle.bold()).padding(.top)
            Divider()
            
            Form {
                TextField("OTP", text: $otp)
                TextField("ARN", text: $arn)
                Divider()
                Picker("STS Profile", selection: $selectedProfile) {
                    ForEach(profiles, id: \.self) {
                        Text($0).font(Font.system(.body, design: .monospaced))
                    }
                }
                Picker("IAM Profile", selection: $selectedIAMProfile) {
                    ForEach(profiles, id: \.self) {
                        Text($0).font(Font.system(.body, design: .monospaced))
                    }
                }
            }.padding([.bottom, .trailing, .leading], 10)
            
            HStack {
                Button(action: {
                    saveValues(arn: &arn, selectedProfile: &selectedProfile, selectedIAMProfile: &selectedIAMProfile, dir: &dir)
                }) {
                    HStack {
                        Image(systemName: "square.and.arrow.down.on.square")
                        Text("Save")
                    }.padding(3)
                }
                Spacer()
                Button(action: {
                    var data = getKeys(otp: &otp, selectedProfile: &selectedProfile, arn: &arn)
                    
                    initConfigurations(data: &data, profile: &selectedIAMProfile)
                    
                })  {
                    HStack {
                        Image(systemName: "terminal")
                        Text("Submit")
                    }.padding(3)
                }
            }.frame(width: 200).padding(.bottom, 10)
            
            Divider()
            Button("Quit") {
                NSApp.terminate(self)
            }.frame(height: 10).position(x: 260, y: 8)
        }.frame(width: 320, height: 320).font(Font.system(.body, design: .monospaced)).textFieldStyle(.roundedBorder).onAppear(perform: {
            fetchProfiles(profiles: &profiles, arn: &arn, selectedProfile: &selectedProfile, selectedIAMProfile: &selectedIAMProfile, dir: &dir)
        })
    }
}

struct PopoverView_Previews: PreviewProvider {
    static var previews: some View {
        PopoverView()
    }
}
