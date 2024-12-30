//
//  CacheableImage.swift
//  FetchRecipesSwiftUI
//
//  Created by David Rynn on 12/25/24.
//

import SwiftUI

struct CacheableImage: View {
    
    @StateObject var viewModel: CacheableImageViewModel
    
    var body: some View {
        switch viewModel.loadingState {
        case .loading:
            ProgressView()
        case .loaded:
            Image(uiImage: viewModel.image)
                .resizable()
                .scaledToFit()
        case .error:
            Image(systemName: "questionmark.video")
        case .empty:
            Image(systemName: "camera")
        }
        
    }
}

