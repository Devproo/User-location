//
//  ContentView.swift
//  User-location
//
//  Created by ipeerless on 12/09/2022.
//

import SwiftUI
import MapKit


struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
   
    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
            .ignoresSafeArea()
            .accentColor(Color(.systemPink))
            .onAppear {
                viewModel.checkIfLocationServiceIsEnabled()
                
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

