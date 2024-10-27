//
//  LocationsView.swift
//  Places
//
//  Created by Nico Francken on 25/10/2024.
//

import SwiftUI

struct LocationsView: View {
    @StateObject var viewModel = LocationsViewModelFactory.shared.getInstance()
    
    var body: some View {
        VStack {
            Text("Locations")
                .font(.largeTitle)
                .accessibilityLabel("Locations title")
                .accessibilityHint("Select coordinate")
            
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
                        .accessibilityLabel("Selects latitude: \(location.latitude) and longitude: \(location.longitude)")
                        .accessibilityHint("Select coordinate")
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
        .accessibilityLabel("Location selection screen")
        .accessibilityHint("Location selection screen")
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
