//
//  BlankView.swift
//  Devote
//
//  Created by Joel Groomer on 1/13/24.
//

import SwiftUI

struct BlankView: View {
    // MARK: - PROPERTIES
    
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(Color.black)
        .opacity(0.5)
        .ignoresSafeArea(.all)
    }
}

// MARK: - PREVIEW
#Preview {
    BlankView()
}
