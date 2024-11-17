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
            Text(viewModel.message)
            Spacer()
                .frame(height: 25)
            Button {
                viewModel.record()
            } label: {
                Image("Record")
            }
        }
    }
}

#Preview {
    RecordView()
}
