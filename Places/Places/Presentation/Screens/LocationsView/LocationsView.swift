//
//  LocationsView.swift
//  Places
//
//  Created by Nico Francken on 25/10/2024.
//

import SwiftUI

struct LocationsView: View {
    @StateObject var viewModel = LocationsViewModel(getLocationsUseCase: GetLocationsUseCaseImp(locationsRepository: LocationsRepositoryImp(locationsApi: LocationsApiImp(apiClient: ApiClientImp()))), launchWikipediaWithCoordinatesUseCase: LaunchWikipediaWithCoordinatesUseCaseImp(wikipediaAppLauncher: WikipediaAppLauncherImp(externalAppLauncher: ExternalAppLauncherImp())))
    
    var body: some View {
        VStack {
            Text("Locations")
                .font(.largeTitle)
            
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(viewModel.locations) { location in
                        Button {
                            viewModel.selectLocation(location)
                        } label: {
                            HStack(alignment: .center) {
                                Text(location.name ?? "")
                                    .font(.title)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                VStack(alignment: .leading) {
                                    Text("Latitude")
                                    Text("\(location.latitude)")
                                }
                                
                                VStack(alignment: .leading) {
                                    Text("Longitude")
                                    Text("\(location.longitude)")
                                }
                            }
                            .padding()
                            
                            .font(.caption)
                            .background(isSelectedLocation(location) ? .blue : .cyan)
                            .cornerRadius(10)
                        }
                    }
                }
            }
        }
        .alert(item: $viewModel.error) { error in
            switch error {
            case .locationPolulationFailed:
                Alert(
                    title: Text("Network error"),
                    message: Text("Unable to retrieve locations"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .padding(.horizontal, 20)
        .foregroundColor(.black)
        .background(Color.white)
        .task {
            await viewModel.populateLocations()
        }
    }
    
    func isSelectedLocation(_ location: LocationUIState) -> Bool {
        location == viewModel.selectedLocation
    }
}

#Preview {
    LocationsView()
}
