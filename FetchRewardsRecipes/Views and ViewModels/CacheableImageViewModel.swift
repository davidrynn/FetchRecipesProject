//
//  CacheableImageViewModel.swift
//  FetchRewardsRecipes
//
//  Created by David Rynn on 12/30/24.
//

import UIKit

final class CacheableImageViewModel: ObservableObject {
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

