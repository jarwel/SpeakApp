//
//  RecordView.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/11/24.
//

import SwiftUI

struct RecordView: View {
    @State var viewModel = RecordViewModel()
    
    var body: some View {
        VStack {
            Text(viewModel.text)
            Spacer()
                .frame(height: 25)
            Button {
                viewModel.stream()
            } label: {
                Image("Record")
            }
        }
    }
}

#Preview {
    RecordView()
}
