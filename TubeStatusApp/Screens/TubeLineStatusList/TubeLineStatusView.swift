//
//  TubeLineStatusView.swift
//  TubeStatusApp
//
//  Created by Admin on 10/11/2023.
//
// This View Displays the list of the tube and status

import SwiftUI
import Combine

struct TubeLineStatusView: View {
    @State private var tubeLines: [TubeListViewModel] = []
    @State private var errorMessage: String?
    @State private var isRefreshing = false
    @Environment(\.colorScheme) var colorScheme

    // Instance of TubeDataInteractor which handles operations for UI
    private let tubeDataInteractor = TubeLineInteractor()
    
    // cancellable to store the Combine subscription
    @State private var cancellable: AnyCancellable?
    
    var body: some View {
        NavigationView {
            VStack {
                if isRefreshing {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .padding()
                        .accessibilityLabel("Loading the data") // Voiceover information
                }
                if let errorMsg = errorMessage, !errorMsg.isEmpty { //unwraping safely
                    Text(errorMsg)
                        .foregroundColor(.red)
                        .padding()
                        .accessibilityLabel(errorMsg) // VoiceOver error message information
                }
                
                //List containing all values
                List(tubeLines, id: \.lineName) { tubeLine in
                    HStack {
                        Rectangle()
                            .frame(width: 10)
                            .foregroundColor(tubeLine.lineUniqueColor.Color.toSUIColor)
                            .accessibility(hidden: true) // Hide the color indicator from VoiceOver
                        
                        HStack {
                            Text(tubeLine.lineName)
                                .font(Font.custom("Arial", size: 20))
                                .minimumScaleFactor(0.3) // Scaling as per need
                                .lineLimit(2) // Limiting the number of lines with 2 at Max
                                .accessibilityHint("The name of the tube which is \(tubeLine.lineName)")
                                .accessibilityLabel(tubeLine.lineName) // Tube name for VoiceOver
                                .foregroundColor(colorScheme == .dark ? Color.black : Color.white) // Handling dark or light mode
                            
                            Spacer(minLength: 10) // to create a min distant
                            Text(tubeLine.lineStatus.description) //status
                                .foregroundColor(tubeLine.lineStatus.color) // color of the status
                                .accessibilityHint("The status of the tube which states \(tubeLine.lineName) is \(tubeLine.lineStatus.description)")
                                .accessibilityLabel(tubeLine.lineStatus.description) // Status info for VoiceOver
                            
                        }
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .background(Color.white) // white background - readability
                        .cornerRadius(8)
                        .shadow(radius: 2) // Depth shadow
                    }
                    .frame(maxWidth: .infinity, alignment: .leading) // Confirming HStack - the full width
                    .accessibilityElement(children: .combine) // Combine child elements for VoiceOver
                }
                .refreshable { //pull to refresh on List
                    await refreshData()
                }
                .navigationTitle("Tube Line Status") // Navigation title
                .accessibilityLabel("Here are the status of Tubes") // Nav Title for VoiceOver
            }
        }
        .onAppear {
            isRefreshing = true // to show progress view for loading the data
            
            // Subscribe to publisher
            cancellable = tubeDataInteractor.tubeDataPublisher
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        self.isRefreshing = false //hide the progress when error occurs
                        errorMessage = error.localizedDescription
                    }
                }, receiveValue: { data in
                    self.isRefreshing = false
                    tubeLines = data  //assign the data from publisher
                })
            
            // Initiate the API request to Interactor
            tubeDataInteractor.fetchTubeData()
        }
        .onDisappear {
            cleanup()
        }
        .foregroundColor(Color.primary)
    }
    
    // Refresh the data on pull to refresh
    private func refreshData() async {
        tubeDataInteractor.refreshData()
    }
    
    // Clean up the subscription when the view disappears
    private func cleanup() {
        cancellable?.cancel()
    }
}

struct TubeLineStatusView_Previews: PreviewProvider {
    static var previews: some View {
        TubeLineStatusView()
    }
}

extension UIColor {
    // Convert UIColor to Color
    var toSUIColor: Color {
        Color(self)
    }
}
