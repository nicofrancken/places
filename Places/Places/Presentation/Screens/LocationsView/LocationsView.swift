//
//  LocationsView.swift
//  Places
//
//  Created by Nico Francken on 25/10/2024.
//

import SwiftUI
import PlacesDomain

struct LocationsView: View {
    @StateObject var viewModel = LocationsViewModelFactory.shared.getInstance()
    @State var latitude: String = ""
    @State var longitude: String = ""
    @State var coordinateValidationError: CoordinateValidationError?
    
    var body: some View {
        VStack(spacing: 30) {
            VStack( spacing: 10) {
                Text("Enter coordinates")
                    .font(.title)
                    .accessibilityLabel("Enter coordinates title")
                
                TextField("Latitude", text: $latitude)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .accessibilityLabel("Latitude textfield")
                    .accessibilityHint("Enter latitude here")
                
                
                TextField("Longitude", text: $longitude)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .accessibilityLabel("Longitude textfield")
                    .accessibilityHint("Enter Longitude here")
                
                if let error = coordinateValidationError {
                    Text(error.LocalizedStringKey)
                        .foregroundColor(.red)
                        .accessibilityLabel("Coordinate error text")
                        .accessibilityHint(error.LocalizedStringKey)
                }
                
                Button("Open in Wiki app") {
                    validateAndLookup()
                }
                .foregroundColor(.white) // Text color
                .padding(.horizontal, 20) // Padding on left and right
                .padding(.vertical, 10) // Padding on top and bottom
                .background(Color.blue) // Background color
                .clipShape(Capsule())
            }
            
            Divider()
            
            VStack {
                Text("Select location")
                    .font(.title)
                    .accessibilityLabel("Select location title")
                
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(viewModel.locations) { location in
                            Button {
                                Task {
                                    await viewModel.launchWiki(location)
                                }
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
                                .foregroundColor(.black)
                                .font(.caption)
                                .background(isSelectedLocation(location) ? .blue : .cyan)
                                .cornerRadius(10)
                            }
                            .accessibilityLabel("Select coordinate button")
                            .accessibilityHint("Opens latitude: \(location.latitude) and longitude: \(location.longitude) in Wikiepdia app")
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
        .accessibilityLabel("Location selection screen")
        .accessibilityHint("Locations can be selected or manually inputted")
        .task {
            await viewModel.populateLocations()
        }
    }
    
    private func isSelectedLocation(_ location: Location) -> Bool {
        location == viewModel.selectedLocation
    }
    
    private func validateAndLookup() {
        if let validationError = CoordinatesValidator.validate(latitude: latitude, longitude: longitude) {
            coordinateValidationError = validationError
            return
        }
        
        if let lat = Double(latitude), let long = Double(longitude) {
            Task {
                await viewModel.launchWiki(Location(name: nil, latitude: lat, longitude: long))
            }
        }
    }
}

#Preview {
    LocationsView()
}
