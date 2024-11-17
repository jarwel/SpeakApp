//
//  RecordHostingController.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/11/24.
//

import SwiftUI
import UIKit

// This subclase allows for better seperation of SwiftUI and UIKit components

class RecordHostingController: UIHostingController<RecordView> {
    
    @MainActor @preconcurrency required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        let rootView = RecordView()
        super.init(rootView: rootView)
    }
    
}
