//
//  RecipesView.swift
//  FetchRecipes
//
//  Created by David Rynn on 12/25/24.
//

import SwiftUI

struct RecipesView: View {
    // MARK: Properties
    @StateObject var viewModel: RecipesViewModel
    private let defaultVerticalSpacing: CGFloat = 16
    
    // MARK: Main body
    var body: some View {
        NavigationStack {
            VStack(spacing: defaultVerticalSpacing) {
                picker
                mainContent()
                Spacer()
            }
            .refreshable {
                Task {
                    await viewModel.loadRecipes()
                }
            }
            .navigationTitle(viewModel.title)
        }
    }
}

// MARK: Subviews
extension RecipesView {
    @ViewBuilder
    func mainContent() -> some View {
        switch viewModel.loadingState {
        case .error:
            errorMessage
        case .empty:
            empty
        case .loaded:
            main
        case .loading:
            loading
        }
    }
    
    var picker: some View {
        VStack {
            Picker("Choose endpoint", selection: $viewModel.selectedEndpoint) {
                ForEach(ResponseTypeSelection.allCases) { endpoint in
                    Text(endpoint.rawValue).tag(endpoint)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: viewModel.selectedEndpoint) {
                Task {
                    await viewModel.loadRecipes()
                }
            }
        }
    }
    
    var main: some View {
        List {
            ForEach(viewModel.recipes) { recipe in
                RecipeSummary(recipe: recipe, dataService: viewModel.dataService)
            }
        }
    }
    
    var errorMessage: some View {
        VStack(spacing: defaultVerticalSpacing) {
            Spacer()
            Image(systemName: "x.circle")
                .resizable()
                .foregroundStyle(.red, .gray)
                .frame(width: 60, height: 60)
            let message = viewModel.errorMessage ?? ""
            Text("Error: \(message)")
            Text("Pull to refresh")
                .foregroundStyle(.gray)
            Spacer()
        }
    }
    
    var loading: some View {
        ProgressView()
            .progressViewStyle(.circular)
    }
    
    var empty: some View {
        VStack(spacing: defaultVerticalSpacing) {
            Spacer()
            Image(systemName: "magnifyingglass")
                .resizable()
                .foregroundStyle(.gray)
                .frame(width: 60, height: 60)
            Text("No recipes found")
                .foregroundStyle(.gray)
            Spacer()
        }
    }
    
}

#Preview {
    let dataService = DataService(networkService: NetworkService(downloader: MockHTTPDataDownloader()))
    let viewModel = RecipesViewModel(dataService: dataService)
    RecipesView(viewModel:viewModel)
}

