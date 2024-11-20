//
//  RecordView.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/11/24.
//

import SwiftUI

struct RecordView: View {
    private enum Constants {
        static let textPlaceholder = "Touch to start recording"
        static let textColor = Color.gray
        static let buttonSize = CGFloat(75)
        static let buttonColor = Color(uiColor: UIColor(_colorLiteralRed: 0.9, green: 0.9, blue: 0.9, alpha: 1))
        static let buttonImage = "Record"
        static let buttonSpacing = CGFloat(20)
    }
    
    @State var viewModel = RecordViewModel(speakService: SpeakServiceMock())
    @State var isRecording  = false
    
    var body: some View {
        VStack {
            if isRecording == true {
                ScrollView(.vertical) {
                    Text(viewModel.text ?? "")
                        .frame(maxHeight: .infinity)
                        .font(.largeTitle)
                        .foregroundColor(Constants.textColor)
                }
            } else {
                Text(Constants.textPlaceholder)
                    .frame(maxHeight: .infinity)
                    .font(.largeTitle)
                    .foregroundColor(Constants.textColor)
            }
            Spacer()
                .frame(height: Constants.buttonSpacing)
            Button {
                isRecording = true
                viewModel.load()
                viewModel.stream()
            } label: {
                Image(Constants.buttonImage)
                    .frame(width: Constants.buttonSize, height: Constants.buttonSize)
                    .background(Constants.buttonColor)
                    .clipShape(Circle())
                    .disabled(viewModel.isRecording)
            }
            Spacer()
                .frame(height: Constants.buttonSpacing)
        }
    }
}

#Preview {
    RecordView()
}
