import SwiftUI
import Combine

struct TubeLineStatusView: View {
    @State private var tubeLines: [TubeListViewModel] = []
    @State private var errorMessage: String?
    @State private var isRefreshing = false

    // Create an instance of TubeDataInteractor
    private let tubeDataInteractor = TubeLineInteractor()
    
    // Use a cancellable to store the Combine subscription
    @State private var cancellable: AnyCancellable?
    
    var body: some View {
        NavigationView {
            VStack {
                if isRefreshing {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .padding()
                        .accessibilityLabel("Loading") // Provide a label for VoiceOver
                }
                if let errorMsg = errorMessage, !errorMsg.isEmpty {
                    Text(errorMsg)
                        .foregroundColor(.red)
                        .padding()
                        .accessibilityLabel(errorMsg) // Provide a label for VoiceOver
                }
                
                List(tubeLines, id: \.lineName) { tubeLine in
                    HStack {
                        Rectangle()
                            .frame(width: 10)
                            .foregroundColor(tubeLine.lineUniqueColor.Color.toSUIColor)
                            .accessibility(hidden: true) // Hide the color indicator from VoiceOver
                        
                        HStack {
                            Text(tubeLine.lineName)
                                .font(Font.custom("Arial", size: 20))
                                .minimumScaleFactor(0.3) // Adjust the scale factor as needed
                                .lineLimit(2) // Specify the maximum number of lines (optional)
                                .accessibilityHint("The name of the tube which is \(tubeLine.lineName)")
                                .accessibilityLabel(tubeLine.lineName) // Provide a label for VoiceOver
                                .foregroundColor(Color.primary) // Ensure sufficient contrast for text
                            
                            Spacer(minLength: 10)
                            Text(tubeLine.lineStatus.description)
                                .foregroundColor(tubeLine.lineStatus.color)
                                .accessibilityHint("The status of the tube which states \(tubeLine.lineName) is \(tubeLine.lineStatus.description)")
                                .accessibilityLabel(tubeLine.lineStatus.description) // Provide a label for VoiceOver
                            
                        }
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .background(Color.white) // Add a white background for better readability
                        .cornerRadius(8)
                        .shadow(radius: 2) // Depth shadow
                    }
                    .frame(maxWidth: .infinity, alignment: .leading) // Confirming HStack - the full width
                    .accessibilityElement(children: .combine) // Combine child elements for VoiceOver
                }
                .refreshable {
                    await refreshData()
                }
                .navigationTitle("Tube Line Status")
                .accessibilityLabel("Here are the status of Tubes") // Provide a label for VoiceOver
            }
        }
        .onAppear {
            isRefreshing = true
            // Fetch tube data when the view appears
            cancellable = tubeDataInteractor.tubeDataPublisher
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        errorMessage = error.localizedDescription
                    }
                }, receiveValue: { data in
                    self.isRefreshing = false
                    tubeLines = data
                })
            
            // Initiate the API request
            tubeDataInteractor.fetchTubeData()
        }
        .onDisappear {
            cleanup()
        }
        .foregroundColor(Color.primary) // Ensure sufficient contrast for text
    }
    
    private func refreshData() async {
        // Update the state variable to stop the refreshing animation
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
    var toSUIColor: Color {
        Color(self)
    }
}

extension View {
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden()
        } else {
            self
        }
    }
}
