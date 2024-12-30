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
/*
#Preview {
    let url = URL(string: "https://www.google.com")
    guard let url else { return EmptyView() }
    let viewModel = CacheableImageViewModel(dataService: DataService(networkService: MockNetworkService))
    return CacheableImage(viewModel: viewModel)
}
 */

class CacheableImageViewModel: ObservableObject {
    @Published var image: UIImage
    @Published var loadingState: LoadingState = .loading
    @Published var errorMessage: String?
    
    private let dataService: DataServicing
    private let url: URL?
    init(dataService: DataServicing, url: URL?) {
        self.dataService = dataService
        self.image = UIImage()
        self.url = url
        Task {
            await loadImage()
        }
    }
    
    @MainActor
    func loadImage() async {
        loadingState = .loading
        do {
            guard let url else {
                throw FetchRecipeError.invalidURL
            }
            let imageData = try await dataService.imageData(from: url)
            let image = UIImage(data: imageData)
            guard let image else {
                loadingState = .error
                return
            }
            self.image = image
            loadingState = imageData.isEmpty ? .empty : .loaded
        } catch {
            loadingState = .error
            if let error = error as? FetchRecipeError {
                errorMessage = error.message
            }
        }
    }
    
}
