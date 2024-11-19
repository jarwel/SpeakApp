//
//  RecordView.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/11/24.
//

import SwiftUI

struct RecordView: View {
    private enum Constants {
        static let startText = "Touch to start recording"
        static let buttonSize = CGFloat(75)
        static let buttonColor = Color(uiColor: UIColor.secondaryLabel)
        static let buttonImage = "Record"
        static let buttonSpacing = CGFloat(20)
    }
    
    @State var viewModel = RecordViewModel(speakService: SpeakServiceMock())
    
    var body: some View {
        VStack {
            Text(viewModel.text ?? Constants.startText)
                .frame(maxHeight: .infinity)
                .font(.largeTitle)
            Spacer()
                .frame(height: Constants.buttonSpacing)
            Button {
                if viewModel.hasEvents {
                    viewModel.stream()
                } else {
                    viewModel.load()
                    viewModel.stream()
                }
            } label: {
                Image(Constants.buttonImage)
                    .frame(width: Constants.buttonSize, height: Constants.buttonSize)
                    .background(Constants.buttonColor)
                    .clipShape(Circle())
            }
            Spacer()
                .frame(height: Constants.buttonSpacing)
        }
    }
}

#Preview {
    RecordView()
}
